import urllib.request, json, csv, time
from flatten_json import flatten

while True:

    with urllib.request.urlopen("https://api.coinmarketcap.com/v2/ticker/?convert=BTC") as urlData, urllib.request.urlopen("https://api.coinmarketcap.com/v2/ticker/?convert=BTC&start=101") as urlData1, urllib.request.urlopen("https://api.coinmarketcap.com/v2/ticker/?convert=BTC&start=201") as urlData2:


        data = []
        data0 = json.load(urlData)
        data1 = json.load(urlData1)
        data2 = json.load(urlData2)
        data.extend([data0, data1, data2])
    #csvFile = open('/tmp/coinMarketCapData.csv', 'w')
    #csvObject = csv.writer(csvFile)
        with open('/home/archyusuf/Dropbox/UbuntuOneStuff/Investment/coinMarketCapData.csv', 'w', newline='') as csvFile:
            csvObject = csv.writer(csvFile)
            count = 0
            for key in data[0]['data']:
                if count == 0:
                    tableHeader = flatten(data[0]['data'][key]).keys()
                    csvObject.writerow(tableHeader)
                count += 1

            for item in data:
                for flatd in item['data']:
                    csvObject.writerow(flatten(item['data'][flatd]).values())
            csvFile.close()
    time.sleep(300)
