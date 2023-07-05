<#
  Name: check_harddisk_hardware
  Version: 1.0
  Created: July, 2023
  Created By: Vinodh G gvinodh@vmware.com
  Description: This Sensor compares the existing harddisk hardware details with the registry values and returns if there is a change in the harddisk hardware.
  Execution Context: System
  Execution Architecture: Auto
  Response Type: String
  Script: Sensor to check the current harddisk details and compare the existing registry values.
#>

##############################################################################

$RegistryDetails = Get-ItemProperty -Path 'HKLM:\SOFTWARE\VMware, Inc.\Workspace One\Device Hardware details'

$HarddiskDetails = Get-PhysicalDisk

if ($HarddiskDetails.Count -gt 1)
{
    if ($HarddiskDetails.Count -eq $RegistryDetails.HardDisk_Count)
    {
        for ($i=0; $i -lt $HarddiskDetails.Count; $i++)
        {
            $HardDiskName = "$i-HardDiskName"
            $HardDiskSerialNumber = "$i-HardDiskSerialNumber"
            $HardDiskSize = "$i-HardDiskSize"
            $HardDiskType = "$i-HardDiskType"
            if ($HarddiskDetails[$i].FriendlyName -eq $RegistryDetails.$HardDiskName -and $HarddiskDetails[$i].SerialNumber -eq $RegistryDetails.$HardDiskSerialNumber -and $HarddiskDetails[$i].Size -eq $RegistryDetails.$HardDiskSize -and $HarddiskDetails[$i].MediaType -eq $RegistryDetails.$HardDiskType)
            {
                return "NO CHANGE"
                exit
            }
            else
            {
                return "CHANGE DETECTED"
                exit
            }
        }
    }
    else
    {
        return "CHANGE DETECTED"
        exit
    }
}
else
{
    if ($HarddiskDetails.FriendlyName -eq $RegistryDetails.HardDiskName -and $HarddiskDetails.SerialNumber -eq $RegistryDetails.HardDiskSerialNumber -and $HarddiskDetails.Size -eq $RegistryDetails.HardDiskSize -and $HarddiskDetails.MediaType -eq $RegistryDetails.HardDiskType)
    {
        return "NO CHANGE"
        exit
    }
    else
    {
        return "CHANGE DETECTED"
        exit
    }
}

