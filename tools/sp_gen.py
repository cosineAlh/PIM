# SPICE generator
# 
#-----------------------------------------------------------------------------------
# This file generates the spice simulation file automatic.
#
# # Instruction
# Do not change if not necessary.
#-----------------------------------------------------------------------------------
# Author: ALH
#-----------------------------------------------------------------------------------

from string import Template
import sys
import re

input_path = "../tools/binary.txt"
tb_path = "../src/vsrc/testbench.v"

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

def ext_pattern(wl, sig, index):
    tmplt = 'b000000000 '
    wl += tmplt
    tmp = list(wl)
    tmp[-9+index-1] = sig
    wl = ''.join(tmp)
    
    return wl

def modify_tb():
    f_tb = open(tb_path, "r+")
    tb = f_tb.readlines()
    tb[1] = '`define latency ' + str(latency) + '\n'
    f_tb.seek(0)
    f_tb.write("".join(tb))
    f_tb.close()

def weight_init(weight):
    array = {}
    for i in range(0, channel):
        tmp = weight[i*kernal].strip('\n')+weight[i*kernal+1].strip('\n')+weight[i*kernal+2].strip('\n')
        tmp = "".join(tmp.split())

        for j in range(0, kernal*kernal):
            address = 'bs'+str(i)+'_wl'+str(j)
            address_b = 'bs'+str(i)+'b_wl'+str(j)
            if tmp[j] == '0':
                array[address] = 'MRAM_cell_P'
                array[address_b] = 'MRAM_cell_P'
            elif tmp[j] == '1':
                array[address] = 'MRAM_cell'
                array[address_b] = 'MRAM_cell_P'
            else:
                tmp = tmp[:j+1] + tmp[j+2:]
                array[address] = 'MRAM_cell_P'
                array[address_b] = 'MRAM_cell'
    return array

def main():
    data = open(input_path,"r+")
    lines = data.readlines()

    # Get the position of im2col data and initial weight
    keyword = ['im2col', 'weight', 'output']
    idx1 = 0
    idx2 = 0
    idx3 = 0
    for i, line in enumerate(lines):
        if keyword[0] in line:
            idx1 = i
        if keyword[1] in line:
            idx2 = i
        if keyword[2] in line:
            idx3 = i
            break

    image = list(filter(lambda x: x!='\n', lines[idx1+1:idx2]))
    weight = list(filter(lambda x: x!='\n', lines[idx2+1:idx3]))

    # Initial the weight
    array = {}
    array = weight_init(weight)

    # Initial the signal dictionary
    signals = {}
    signals['en'] = ''
    signals['pec'] = ''
    signals['rw'] = ''
    signals['period'] = ''
    for i in range(0, kernal*kernal):
        signals['wl'+str(i)]  = ''
    for i in range(0, channel):
        signals['bl'+str(i)]  = ''
        signals['sl'+str(i)]  = ''
        signals['bl'+str(i)+'b']  = ''
        signals['sl'+str(i)+'b']  = ''

    # Get the input patterns of each signal
    group_num = len(image)
    signals['period'] = str(group_num*kernal*kernal*5) + 'ns'
    for i in range(0, group_num):
        signals['en'] += 'b111111111 '
        signals['rw'] += 'b111111111 '
        signals['pec'] += 'b010101010101010101 '
        for j in range(0,kernal*kernal):
            signals['wl'+str(j)] = ext_pattern(signals['wl'+str(j)], image[i][j], j)
        for k in range(0, channel):
            signals['bl'+str(k)] += 'b000000000 '
            signals['sl'+str(k)] += 'b000000000 '
            signals['bl'+str(k)+'b'] += 'b000000000 '
            signals['sl'+str(k)+'b'] += 'b000000000 '

    signals['timestep'] = '2.5ns'

    # Template substitution
    test_template = Template(open('../templates/test.sp.tmpl').read())
    test_out= test_template.substitute(signals)
    open('../src/sp/test.sp', 'w').write(test_out)
    data.close()

    array_template = Template(open('../templates/array.sp.tmpl').read())
    array_out= array_template.substitute(array)
    open('../src/sp/array.sp', 'w').write(array_out)

    modify_tb()

if __name__ == '__main__':
    main()