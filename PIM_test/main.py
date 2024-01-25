import torch
import torchvision
from torch.utils.data import DataLoader
import torch.nn as nn
import torch.nn.functional as F
import torch.optim as optim
import sklearn.preprocessing as sp
import numpy as np
from typing import Tuple
import matplotlib.pyplot as plt

n_epochs = 1
batch_size_train = 100
batch_size_test = 1000
learning_rate = 0.01
momentum = 0.5
log_interval = 10
random_seed = 1
torch.manual_seed(random_seed)

#============ Load ==============
train_loader = torch.utils.data.DataLoader(
    torchvision.datasets.MNIST('./data/', train=True, download=True,
                               transform=torchvision.transforms.Compose([
                                   torchvision.transforms.ToTensor(),
                                   torchvision.transforms.Normalize(
                                       (0.1307,), (0.3081,))])),
    batch_size=batch_size_train, shuffle=True)
test_loader = torch.utils.data.DataLoader(
    torchvision.datasets.MNIST('./data/', train=False, download=True,
                               transform=torchvision.transforms.Compose([
                                   torchvision.transforms.ToTensor(),
                                   torchvision.transforms.Normalize(
                                       (0.1307,), (0.3081,))])),
    batch_size=batch_size_test, shuffle=True)

#============ Binary the Inputs ==============
def binary(data):
    data = data.numpy()
    for i in range(data.shape[0]):
        bin = sp.Binarizer(threshold=0.5)
        data[i][0] = bin.transform(data[i][0])

    data = torch.from_numpy(data)
    return data

examples = enumerate(test_loader)
batch_idx, (example_data, example_targets) = next(examples)
example_data = binary(example_data)
#print(example_targets)
#print(example_data.shape)

# plot examples
#fig = plt.figure()
#for i in range(6):
#    plt.imsave('./image/'+str(example_targets[i])+'.png',example_data[i][0], cmap='gray')
#    plt.subplot(2, 3, i + 1)
#    plt.tight_layout()
#    plt.imshow(example_data[i][0], cmap='gray')
#    plt.title("Ground Truth: {}".format(example_targets[i]))
#    plt.xticks([])
#    plt.yticks([])
#plt.show()

#============ Construct Module ==============
class Net(nn.Module):
    def __init__(self):
        super(Net, self).__init__()
        self.conv = nn.Conv2d(1, 10, kernel_size=3, padding=0, bias=False)
        self.fc1 = nn.Linear(26*26*10, 256, bias=False)
        self.fc2 = nn.Linear(256, 64, bias=False)
        self.fc3 = nn.Linear(64, 10, bias=False)

    def forward(self, x):
        x = F.relu(self.conv(x))
        x = x.view(-1, 26*26*10)
        x = F.relu(self.fc1(x))
        x = F.relu(self.fc2(x))
        x = F.log_softmax(self.fc3(x), 1)
        #x = self.fc3(x)
        return x

train_losses = []
train_counter = []
test_losses = []
test_counter = []

def train(model: nn.Module, epoch):
    model.train()
    for batch_idx, (data, target) in enumerate(train_loader):
        optimizer.zero_grad()
        data = binary(data)
        output = model(data)
        loss = F.nll_loss(output, target)
        loss.backward()
        optimizer.step()
        if batch_idx % log_interval == 0:
            print('Train Epoch: {} [{}/{} ({:.0f}%)]\tLoss: {:.6f}'.format(epoch, batch_idx * len(data),
                                                                           len(train_loader.dataset),
                                                                           100. * batch_idx / len(train_loader),
                                                                           loss.item()))
            train_losses.append(loss.item())
            train_counter.append((batch_idx * 64) + ((epoch - 1) * len(train_loader.dataset)))
            torch.save(model.state_dict(), './model.pth')
            torch.save(optimizer.state_dict(), './optimizer.pth')

def test(model: nn.Module):
    model.eval()
    test_loss = 0
    correct = 0

    with torch.no_grad():
        for data, target in test_loader:
            data = binary(data)
            output = model(data)
            test_loss += F.nll_loss(output, target, reduction='sum').item()
            pred = output.data.max(1, keepdim=True)[1]
            correct += pred.eq(target.data.view_as(pred)).sum()

    test_loss /= len(test_loader.dataset)
    test_losses.append(test_loss)
    print('\nTest set: Avg. loss: {:.4f}, Accuracy: {}/{} ({:.0f}%)\n'.format(
        test_loss, correct, len(test_loader.dataset),
        100. * correct / len(test_loader.dataset)))

# ----------------------------------------------------------- #
#============ Quantize Weight ==============
def quantized_weights(weights: torch.Tensor) -> Tuple[torch.Tensor, float]:
    abs_in = torch.abs(weights)
    f_max = torch.max(abs_in)
    f_min = torch.min(abs_in)
    scale = 2 / (f_max-f_min)
    result =(weights*scale).round()
    #print(scale)
    
    return torch.clamp(result, min=-1, max=1), scale

def quantize_layer_weights(model: nn.Module):
    # Quantize the weights layer by layer and record the scale factors and quantized weights
    for layer in model.children():
        if isinstance(layer, nn.Conv2d) or isinstance(layer, nn.Linear):
            # Quantize the weights using the function you just developed
            q_layer_data, scale = quantized_weights(layer.weight.data)

            layer.weight.data = q_layer_data
            layer.weight.scale = scale
            
            # Check if the weights are quantized properly, your code should be okay if no exception is raised.
            if (q_layer_data < -1).any() or (q_layer_data > 1).any():
                raise Exception("Quantized weights of {} layer include values out of bounds for an 1-bit signed integer".format(layer.__class__.__name__))
            if (q_layer_data != q_layer_data.round()).any():
                raise Exception("Quantized weights of {} layer include non-integer values".format(layer.__class__.__name__))

# ----------------------------------------------------------- #
#============ Train and Test ==============
network = Net()
optimizer = optim.SGD(network.parameters(), lr=learning_rate, momentum=momentum)

#model = torch.load('model.pth')
#network.load_state_dict(model)
#torch.save(network.state_dict(), 'model_dict.pth')
#optimizer_state_dict = torch.load('optimizer.pth')
#optimizer.load_state_dict(optimizer_state_dict)
#torch.save(optimizer.state_dict(), 'optimizer_dict.pth')

for epoch in range(0, n_epochs):
    test_counter.append(epoch*len(train_loader.dataset))
    train(network, epoch)

    if (epoch == n_epochs-1):
        quantize_layer_weights(network)

    test(network)

conv_weights = network.conv.weight.data.cpu().view(-1)
print(conv_weights)

# ----------------------------------------------------------- #
#============ Plot Results ==============
fig = plt.figure()
plt.plot(train_counter, train_losses, color='blue')
plt.scatter(test_counter, test_losses, color='red')
plt.legend(['Train Loss', 'Test Loss'], loc='upper right')
plt.xlabel('number of training examples')
plt.ylabel('loss')
plt.show()

with torch.no_grad():
    output = network(example_data)

fig = plt.figure()
for i in range(6):
    plt.subplot(2, 3, i + 1)
    plt.tight_layout()
    plt.imshow(example_data[i][0], cmap='gray')
    plt.title("Prediction: {}".format(output.data.max(1, keepdim=True)[1][i].item()))
    plt.xticks([])
    plt.yticks([])
plt.show()
