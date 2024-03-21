#!/usr/bin/env python3

import sys

def main():
    wanted_columns = list(map(lambda x: x.upper(), sys.argv[1:]))

    firstline = sys.stdin.readline()
    l = firstline
    l = zip(range(len(l)), l, l[1:] + " ")
    l = filter(lambda x: x[1] == ' ' and x[2] != ' ', l)
    l = list(map(lambda x: x[0]+1, l))
    l = zip([0] + l, l)
    l = {firstline[x[0]:x[1]].rstrip() : x for x in l}
    l = dict(l)


    coloured_bars = {
        "▂___" : "<span color ='#f38ba8'>▂</span>▄▆█",
        "▂▄__" : "<span color ='#fab387'>▂▄</span>▆█",
        "▂▄▆_" : "<span color ='#f9e2af'>▂▄▆</span>█",
        "▂▄▆█" : "<span color ='#a6e3a1'>▂▄▆█</span>",
    }

    for line in sys.stdin:

        entries = [] 
        for col in wanted_columns:
            val = line[l[col][0]:l[col][1]].rstrip()
            if col == 'BARS':
                val = coloured_bars.get(val, '') 
            entries.append(val)

        print("\t".join(entries))


if __name__ == "__main__":
    main()

