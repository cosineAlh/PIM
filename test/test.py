# SPICE to verilog
# 
#-----------------------------------------------------------------------------------
# This file check the output file with ground truth.
#
# # Instruction
# Do not change if not necessary.
#-----------------------------------------------------------------------------------
# Author: ALH
#-----------------------------------------------------------------------------------

import sys

#img_h = 8
img_h = int(sys.argv[1])
#img_w = 8
img_w = int(sys.argv[2])

output_path = "../src/vsrc/array_output.txt"
ground_path = "../tools/decimal.txt"

def main():
    ground = open(ground_path,"r")
    ground_ = ground.readlines()
    output = open(output_path,"r")
    output_ = output.readlines()[1:]

    # Get the position of the answer
    keyword = 'output'
    idx1 = 0
    for i, line in enumerate(ground_):
        if keyword in line:
            idx1 = i
            break
    ground_ = list(filter(lambda x: x!='\n', ground_[idx1+1:-1]))

    # Reorder the answer
    answer = []
    results = []
    for i in range(0, int(len(ground_)/(img_h-2))):
        answer.append('')
        results.append('')
        for j in range(0, img_w-2):
            answer[i] += ground_[i*(img_h-2)+j].strip()
        answer[i] = "".join(answer[i].strip().split('\t'))

    # Get the results
    for line_o in output_:
        line_o = "".join(line_o.strip().split())
        for i in range(0, len(line_o)):
            results[i] += line_o[i]

    # Compare
    if (answer == results):
        print("PASSED!")
    else:
        print('Answer:\n'+ str(answer))
        print('Result:\n'+ str(results))
        print("FAILD!")
        
    ground.close()
    output.close()

if __name__ == '__main__':
    main()