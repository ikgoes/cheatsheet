import sys
import warnings
from pprint import pprint
import requests
import pandas as pd

df = pd.read_csv('Devices.csv')
warnings.filterwarnings("ignore")

account = "ID:PW"
res = "/redfish/v1/Chassis/System.Embedded.1/PCIeSlots"

gpu_list = list()
for hostname,ip in df[['Name','IP Address']].values.tolist():
    resp = requests.get("https://"+account+"@"+ip+res, verify=False)
    for item in dict(resp.json())["Slots"]:
        if item['Links']['PCIeDevice']:
            gpu_candi = item['Links']['PCIeDevice'][0]['@odata.id']
            
            response = requests.get("https://"+account+"@"+ip+gpu_candi, verify=False)
            if "NVIDIA" in response.text:
                print(','.join([hostname,ip, response.json()['Description'], response.json()['@odata.etag']]))
                gpu_list.append(','.join([hostname,ip, response.json()['Description'], response.json()['@odata.etag']]))
                
with open("gpu_list.csv","w") as f:
    for line in gpu_list:
        f.write(line + '\n')