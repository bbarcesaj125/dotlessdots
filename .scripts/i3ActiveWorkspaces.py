import sys, json

""" 
This is a Python script that works as an i3 workspace indicator.
It uses an icon font (e.g., Awesome) to output a string of icons that change depending 
on the workspaces' status.
It should be used with a bash script wrapper that feeds it the list of workspaces using the i3 command `i3-msg`.
"""

for line in sys.stdin:
    #print (line)
    data = json.loads(line)
    d = {"α: www": 0, "β: www1": 1, "γ: zim": 2, "δ: video": 3, "ε: manga": 4, "ζ: term": 5, "η: fm": 6, "θ: gimp": 7, "ι: misc": 8}
    e = ["", "", "", "", "", "", "", "", ""]
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
