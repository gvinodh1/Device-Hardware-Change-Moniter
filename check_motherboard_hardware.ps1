<#
  Name: check_motherboard_hardware
  Version: 1.0
  Created: July, 2023
  Created By: Vinodh G gvinodh@vmware.com
  Description: This Sensor compares the existing motherboard hardware details with the registry values and returns if there is a change in the motherboard hardware.
  Execution Context: System
  Execution Architecture: Auto
  Response Type: String
  Script: Sensor to check the current motherboard details and compare the existing registry values.
#>

##############################################################################

$RegistryDetails = Get-ItemProperty -Path 'HKLM:\SOFTWARE\VMware, Inc.\Workspace One\Device Hardware details'

$MotherBoardDetails = Get-WmiObject win32_baseboard

if ($MotherBoardDetails.Count -gt 1)
{
    if ($MotherBoardDetails.Count -eq $RegistryDetails.MotherBoard_Count)
    {
        for ($i=0; $i -lt $MotherBoardDetails.Count; $i++)
        {
            $MotherBoardManufacturer = "$i-MotherBoardManufacturer"
            $MotherBoardName = "$i-MotherBoardName"
            $MotherBoardSerialNumber = "$i-MotherBoardSerialNumber"
            if ($MotherBoardDetails[$i].Manufacturer -eq $RegistryDetails.$MotherBoardManufacturer -and $MotherBoardDetails[$i].Name -eq $RegistryDetails.$MotherBoardName -and $MotherBoardDetails[$i].SerialNumber -eq $RegistryDetails.$MotherBoardSerialNumber)
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
    if ($MotherBoardDetails.Manufacturer -eq $RegistryDetails.MotherBoardManufacturer -and $MotherBoardDetails.Name -eq $RegistryDetails.MotherBoardName -and $MotherBoardDetails.SerialNumber -eq $RegistryDetails.MotherBoardSerialNumber)
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

