import requests, json, time, csv

headers = {
    'X-MBX-APIKEY': 'uFj3gSyYkvw9heydXsfX4O0AKb0DeFXDEdXRUMPNUnSIdNUSbYNC27hlFiV0fX8O',
}

test = 0
def json_to_csv(data):
    with open('/home/archyusuf/Dropbox/UbuntuOneStuff/Investment/binanceData.csv', 'w', newline='') as csv_data:                                                                                                                                             
        csv_file = csv.writer(csv_data)                                                                                                                                                                                                                           
        count = 0                                                                                                                                                                                                                                                 
        for key in data:                                                                                                                                                                                                                               
            if count == 0:                                                                                                                                                                                                                                        
                table_header = key.keys()                                                                                                                                                                                                
                csv_file.writerow(table_header)                                                                                                                                                                                                                   
                count += 1                                                                                                                                                                                                                                            
            csv_file.writerow(key.values())                                                                                                                                                                                         
        csv_data.close()                     

while True:
    if test == 0:
        anchor_response = requests.get('https://api.binance.com/api/v1/ticker/24hr', headers=headers)
        anchor_data = anchor_response.json()
        test += 1
    else:
        latest_response = requests.get('https://api.binance.com/api/v1/ticker/24hr', headers=headers)
        latest_data = latest_response.json()
        for i, j in zip(anchor_data, latest_data):
            if i['symbol'] == j['symbol']:
                if float(i['volume']) == 0:
                    j['volumeChangePercent'] = 0
                elif float(i['lastPrice']) == 0:
                    j['customPriceChangePercent'] = 0
                else:
                    j['volumeChangePercent'] = ((float(j['volume']) - float(i['volume'])) / float(i['volume'])) 
                    j['customPriceChangePercent'] = ((float(j['lastPrice']) - float(i['lastPrice'])) / float(i['lastPrice'])) 
        anchor_data = latest_data
        json_to_csv(latest_data)
    time.sleep(200)
