# Testcase
# 
#-----------------------------------------------------------------------------------
# This file generates the testcases and groundtruth in both binary and decimal type.
#
# # Instruction
# - Can modify thie file to change the input image size.
#-----------------------------------------------------------------------------------
# Author: ALH
#-----------------------------------------------------------------------------------

import torch
import torch.nn as nn
import numpy as np
import sys

#kernal = 3
kk = int(sys.argv[1])

ic = 1
#img_h = 8
ih = int(sys.argv[3])
#img_w = 8
iw = int(sys.argv[4])

#channel = 10
oc = int(sys.argv[2])
oh = ih-2
ow = iw-2

conv2d = nn.Conv2d(in_channels=ic, out_channels=oc, kernel_size=kk, padding=0, bias=False)
relu = nn.ReLU(inplace=False)

# randomize input feature map
#input = torch.rand(1, ic, ih, iw)*255-128
input = torch.rand(1, ic, ih, iw)*2-1
input = torch.abs(torch.round(input))

# randomize weight
weight = torch.rand(oc, ic, kk, kk)*2-1
weight = torch.round(weight)
#weight = torch.abs(torch.round(weight))

# setting the kernel of conv2d as weight
conv2d.weight = nn.Parameter(weight)

# computing output
output = conv2d(input)
output_relu = relu(output)

input_np = input.data.numpy().astype(int)
weight_np = weight.data.numpy().astype(int)
output_np = output_relu.data.numpy().astype(int)

# write data as 2's complement binary representation type
with open("../tools/binary.txt", "w") as f:
    f.write("***************input***************\n")
    for i in range(ic):
        for j in range(ih):
            for k in input_np[0, i, j, :]:
                s = np.binary_repr(k, 1) + " "
                f.write(s)
            f.write("\n")
        f.write("\n")

    f.write("***************im2col***************\n")
    for i in range(ic):
        for j in range(oh):
            for k in range(ow):
                s = np.binary_repr(input_np[0, i, j, k], 1) + np.binary_repr(input_np[0, i, j, k+1], 1) + np.binary_repr(input_np[0, i, j, k+2], 1)
                s = s + np.binary_repr(input_np[0, i, j+1, k], 1) + np.binary_repr(input_np[0, i, j+1, k+1], 1) + np.binary_repr(input_np[0, i, j+1, k+2], 1)
                s = s + np.binary_repr(input_np[0, i, j+2, k], 1) + np.binary_repr(input_np[0, i, j+2, k+1], 1) + np.binary_repr(input_np[0, i, j+2, k+2], 1)
                f.write(s)
                f.write("\n")
            f.write("\n")
        f.write("\n")

    f.write("***************weight***************\n")
    for i in range(oc):
        for j in range(ic):
            for k in range(kk):
                for l in weight_np[i, j, k, :]:
                    #s = np.binary_repr(l, 1) + " "
                    s = str(l) + " "
                    f.write(s)
                f.write("\n")
            f.write("\n")
        f.write("\n")

    f.write("***************output***************\n")
    for i in range(oc):
        for j in range(oh):
            for k in output_np[0, i, j, :]:
                s = np.binary_repr(k, 4) + " "
                f.write(s)
            f.write("\n")
        f.write("\n")


# write out data as decimal type
with open("../tools/decimal.txt", "w") as f:
    f.write("***************input***************\n")
    for i in range(ic):
        for j in range(ih):
            for k in input_np[0, i, j, :]:
                s = str(k) + "\t"
                f.write(s)
            f.write("\n")
        f.write("\n")

    f.write("***************weight***************\n")
    for i in range(oc):
        for j in range(ic):
            for k in range(kk):
                for l in weight_np[i, j, k, :]:
                    s = str(l) + " "
                    f.write(s)
                f.write("\n")
            f.write("\n")
        f.write("\n")

    f.write("***************output***************\n")
    for i in range(oc):
        for j in range(oh):
            for k in output_np[0, i, j, :]:
                s = str(k) + "\t"
                f.write(s)
            f.write("\n")
        f.write("\n")