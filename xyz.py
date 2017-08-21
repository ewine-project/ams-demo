import sys
import numpy

input_file_name = 'input.txt'
output_file_name = 'output.txt'

input_mat=numpy.zeros((8,2))
cnt1 = 0
cnt2 = 0
for line in open(input_file_name, 'r'):
    if (line[0] != '#'):
        if (cnt2 == 0):
            input_mat[cnt1, cnt2] = round(float(line))
        else:
            input_mat[cnt1, cnt2] = float(line)
        if (cnt2 == 0):
            cnt2 = 1
        else:
            cnt2 = 0
            cnt1 = cnt1+1

#print input_mat
output_file = open(output_file_name, 'w')
output_file.write('# This file was written by the script xyz.py\n')
output_file.write(input_mat.max(axis=0).astype('str')[0])
output_file.write('\n')
output_file.write(input_mat.sum(axis=0).astype('str')[1])
output_file.write('\n')
output_file.write((-input_mat.max(axis=0)).astype('str')[1])
output_file.write('\n')
output_file.close()
