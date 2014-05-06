#!/opt/Python/2.7.3/bin/python
import sys
from collections import defaultdict
from numpy import *
import re
import os
import argparse
from Bio import SeqIO

def usage():
    test="name"
    message='''
python CircosConf.py --input circos.config --output pipe.conf

    '''
    print message

def fasta_id(fastafile):
    fastaid = defaultdict(str)
    for record in SeqIO.parse(fastafile,"fasta"):
        fastaid[record.id] = 1
    return fastaid


'''
Chr1    65934   65943   Deletion        SV193_0 +       0       0       9       0.0000000
Chr1    65944   65953   Deletion        SV193_1 +       0       0       9       0.0000000
'''
def binlevel(coverage, prefix):
    data = defaultdict(list)
    sumdata  = defaultdict(list) 
    s = re.compile(r'(SV\d+)\_(\d+)')
    with open (coverage, 'r') as filehd:
        for line in filehd:
            line = line.rstrip()
            if len(line) > 2:
                unit = re.split(r'\t', line)
                m = s.search(unit[4])
                if m:
                    sv = m.groups(0)[0]
                    n  = m.groups(0)[1]
                    data[sv].append(unit[9])
                    sumdata[n].append(float(unit[9]))
                    #print sv, unit[9]
    ofile = open (prefix + '.binlevel.sum', 'w')
    for i in sorted(sumdata.keys(), key = int):
        print >> ofile, "%s\t%s" %(i, mean(sumdata[i]))
    ofile.close()
'''
Chr1    100145  103713  Deletion        SV1     +
'''
def generateWin(infile, flank, win):
    data = defaultdict(str)
    ofile = open('SV.flank_win.bed', 'w')
    with open (infile, 'r') as filehd:
        for line in filehd:
            line = line.rstrip()
            if len(line) > 2: 
                unit = re.split(r'\t',line)
                count = 0
                ## upstream windows
                up_start = int(unit[1])-int(flank)+1
                for i in range(int(flank)/int(win)+5):
                    count = i
                    s = up_start + i*win
                    e = s + win - 1
                    n = unit[4] + '_' + str(count)
                    print >> ofile, "%s\t%s\t%s\t%s\t%s\t%s"  % (unit[0], s, e, unit[3], n, unit[5])
                count = count + 1
                ## in windows, SV > 50 bp, so if win is 10 we pick two at each side
                #print line
                ## downstream windows
                down_start = int(unit[2]) - 5*win + 1
                for i in range(int(flank)/int(win)+5):
                    count = count + 1
                    s = down_start + i*win
                    e = s + win - 1
                    n = unit[4] + '_' + str(count)
                    print >> ofile, "%s\t%s\t%s\t%s\t%s\t%s"  % (unit[0], s, e, unit[3], n, unit[5])
    ofile.close()    

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('-g', '--gff')
    parser.add_argument('-r', '--repeat')
    parser.add_argument('-p', '--project')
    parser.add_argument('-v', dest='verbose', action='store_true')
    args = parser.parse_args()
    try:
        len(args.gff) > 0
    except:
        usage()
        sys.exit(2)

    flank = 200
    win   = 10
    generateWin(args.gff, flank, win)
    os.system('bedtools coverage -b SV.flank_win.bed -a ' + args.repeat + '| sort -k1,1 -k2,2n > SV.flank_win.bed.' + args.project + '.coverage')
    binlevel('SV.flank_win.bed.' + args.project + '.coverage', 'SV.flank_win.bed.' + args.project)

if __name__ == '__main__':
    main()

