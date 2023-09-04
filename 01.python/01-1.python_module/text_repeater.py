f=open("./tmp2.txt",'w')

'''
for i in range(2,29):
    t = """
    SetCurrentFolder    Root\\01.HQ\\1.Server\\11.iDRAC\\Worker\\lesasbpdp58\\
    CopyFolder    -r    Root\\01.HQ\\1.Server\\11.iDRAC\\Worker\\lesasbpdp58\\ Root\\01.HQ\\1.Server\\11.iDRAC\\Worker\\lesasbpdp{}\\
    CopyAllTests  -r -skipduplicates    Root\\01.HQ\\1.Server\\11.iDRAC\\Worker\\lesasbpdp{}\\
    SetCurrentFolder    Root\\01.HQ\\1.Server\\11.iDRAC\Worker\lesasbpdp{}\\
    SetFolderVariable   fvar_ ip    "10.93.34.1{}"
    """.format(i,i,i,i)

    t = """
    SetCurrentFolder    Root\\01.HQ\\1.Server\\12.SBP\\GPDB\\SBP-GPDB_10.119\\
    CopyFolder    -r    Root\\01.HQ\\1.Server\\12.SBP\\GPDB\\SBP-GPDB_10.119\\ Root\\01.HQ\\1.Server\\12.SBP\\GPDB\\SBP-GPDB_11.{}\\
    CopyAllTests  -r -skipduplicates    Root\\01.HQ\\1.Server\\12.SBP\\GPDB\\SBP-GPDB_11.{}\\
    SetCurrentFolder    Root\\01.HQ\\1.Server\\12.SBP\\GPDB\\SBP-GPDB_11.{}\\
    SetFolderVariable   fvar_ip    "192.168.11.{}"
    """.format(i,i,i,i)
    f.write(t)

for i in ["%.2d" % i for i in range(2,29)]:    
    t = """
    SetCurrentFolder    Root\\03.ESWA\\1.Server\\13.ESX\\vmHost\\WA_ESX01\\
    CopyFolder    -r    Root\\03.ESWA\\1.Server\\13.ESX\\vmHost\\WA_ESX01\\ Root\\03.ESWA\\1.Server\\13.ESX\\vmHost\\WA_ESX{}\\
    CopyAllTests  -r -skipduplicates    Root\\03.ESWA\\1.Server\\13.ESX\\vmHost\\WA_ESX{}\\
    SetCurrentFolder    Root\\03.ESWA\\1.Server\\13.ESX\\vmHost\\WA_ESX{}\\
    SetFolderVariable   fvar_ip    "192.168.220.2{}"
    """.format(i,i,i,i)
'''
for i in ["%.2d" % i for i in (list(range(4,7))+list(range(17,21)))]:   
    t = """
    SetCurrentFolder    Root\\03.ESWA\\1.Server\\13.ESX\\GPU\\GPU_220.203\\
    CopyFolder    -r    Root\\03.ESWA\\1.Server\\13.ESX\\GPU\\GPU_220.203\\ Root\\03.ESWA\\1.Server\\13.ESX\\GPU\\GPU_220.2{}\\
    CopyAllTests  -r -skipduplicates    Root\\03.ESWA\\1.Server\\13.ESX\\GPU\\GPU_220.2{}\\
    SetCurrentFolder    Root\\03.ESWA\\1.Server\\13.ESX\\GPU\\GPU_220.2{}\\
    SetFolderVariable   fvar_ip    "192.168.220.2{}"
    """.format(i,i,i,i)
    f.write(t)

f.close()