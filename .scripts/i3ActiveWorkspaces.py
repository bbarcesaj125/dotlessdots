import sys, json

for line in sys.stdin:
    #print (line)
    data = json.loads(line)
    d = {"α: www": 0, "β: zim": 1, "γ: video": 2, "δ: manga": 3, "ε: term": 4, "ζ: fm": 5, "η: gimp": 6, "θ: misc": 7}
    e = [ "", "", "", "", "", "", "", "" ]
    y = []
    s = []
    for i, name in enumerate(k['name'] for k in data):
        y.append(d[name])
        for a in y:
            e[a] = ""
            #print (e)
    for i, focused in enumerate(f['focused'] for f in data):

        if focused == True:
            dd = data[i]['name']
            #print(dd)

            kk = d[dd]
            #print(kk)
            e[kk] = ""
            #print(e)
            r = ''.join(e)
            print(r)
