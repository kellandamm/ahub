<# 
Azure Hybrid Use Benefit enable for Window VM's in Subscription
BY KELLAN DAMM
3-31-2020   
Can be utilized in Azure Cloud shell through bash


DISCLAIMER: The information contained in this script and any accompanying materials 
(including, but not limited to, scripts, sample codes, etc.) are provided “AS-IS” and “WITH ALL FAULTS.” 
Any estimated pricing information is provided solely for demonstration purposes 
and does not represent final pricing and Microsoft assumes no liability arising from your use of the information. 
Microsoft makes NO GUARANTEES OR WARRANTIES OF ANY KIND, WHETHER EXPRESSED OR IMPLIED, in providing this information, 
including any pricing information.
#>

#!/bin/bash

#List VM's currently with Windows_Server Enabled
echo Exporting list before ahub enablement exporting to beforedeployment.txt file
az vm list --query "[?licenseType=='Windows_Server']" -o table > beforedeployment.txt


#Exporting Name and ResourceGroup to json
echo Exporting Windows list to json
$result az vm list --query "[].{name:name, resource:resourceGroup}" -o json


#Loops through json to enable AHUB benefits
for vms in $result ; do
    name = vms.name
    ResourceGroup = vms.resource

    az vm update --name $name --resource-group $resourceGroup --set LicenseType="Windows_Server"
done

#lists VM's that now have AHUB benefits enabled
echo Exporting list after ahub enablement exporting to afterdeployment.txt file
az vm list --query "[?licenseType=='Windows_Server']" -o table > afterdeployment.txt
