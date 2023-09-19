# SPICE to verilog
# 
#-----------------------------------------------------------------------------------
# This file transform the SPICE output file into txt file.
#
# # Instruction
# Do not change if not necessary.
#-----------------------------------------------------------------------------------
# Author: ALH
#-----------------------------------------------------------------------------------

import sys
import copy

#kernal = 3
kernal = int(sys.argv[1])
#channel = 10
channel = int(sys.argv[2])
#img_h = 8
img_h = int(sys.argv[3])
#img_w = 8
img_w = int(sys.argv[4])
#
latency = int((img_h-2)*(img_w-2)*kernal*kernal*(5/2.5))

a2d_path = "../src/logs/test.a2d"

def split_text(input):
    index = []
    output = []

    # create new list
    for line in input:
        line = line.split()
        if (line[0] not in index):
            index.append(line[0])
            output.append(line[1:2*channel+1])
        else:
            output[-1] += (line[1:2*channel+1])

    # extend the list
    for i in range(0,len(output)):
        if len(output[i]) != 2*channel:
            output[i].sort(key=lambda x: int(x.split(':')[1]))
            tmp = copy.deepcopy(output[i-1])
            for j in range(0,len(output[i])):
                tmp[int(output[i][j].split(':')[1])-1] = output[i][j]
            output[i] = tmp
        else:
            output[i].sort(key=lambda x: int(x.split(':')[1]))

    # check the list
    if (len(index) != latency):
        for i in range(0,latency):
            if i<len(index):
                if int(index[i]) != i:
                    index.insert(i,str(i))
                    output.insert(i,copy.deepcopy(output[i-1]))
            else:
                index.append(str(i))
                output.append(copy.deepcopy(output[i-1]))
    return output

def main():
    data = open(a2d_path,"r")
    lines = data.readlines()[1:]

    # split the input data
    input = []
    new_data = []
    timestep = 1
    new_data = split_text(lines)

    # split
    for i in range(0, int(len(new_data)/timestep)):
        tmp = new_data[i*timestep]

        for j in range(0,2*channel):
            tmp[j] = tmp[j].split(':')[0]
        input.append(tmp)

    print(len(input)) # size of the input

    # write the result into a file
    with open("../src/vsrc/array_input.txt", "w") as f:
        for i in range(0, len(input)):
            for j in range(0, 2*channel):
                f.write(input[i][2*channel-1-j])
            f.write("\n")
    
    data.close()

if __name__ == '__main__':
    main()