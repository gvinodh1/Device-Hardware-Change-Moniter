<#
  Name: check_ram_hardware
  Version: 1.0
  Created: July, 2023
  Created By: Vinodh G gvinodh@vmware.com
  Description: This Sensor compares the existing RAM hardware details with the registry values and returns if there is a change in the RAM hardware.
  Execution Context: System
  Execution Architecture: Auto
  Response Type: String
  Script: Sensor to check the current RAM details and compare the existing registry values.
#>

##############################################################################

$RegistryDetails = Get-ItemProperty -Path 'HKLM:\SOFTWARE\VMware, Inc.\Workspace One\Device Hardware details'

$RAMDetails = Get-CimInstance -Class CIM_PhysicalMemory

if ($RAMDetails.Count -gt 1)
{
    if ($RAMDetails.Count -eq $RegistryDetails.RAM_Count)
    {
        for ($i=0; $i -lt $RAMDetails.Count; $i++)
        {
            $RAMManufacturer = "$i-RAMManufacturer"
            $RAMSerialNumber = "$i-RAMSerialNumber"
            $RAMCapacity = "$i-RAMCapacity"
            if ($RAMDetails[$i].Manufacturer -eq $RegistryDetails.$RAMManufacturer -and $RAMDetails[$i].SerialNumber -eq $RegistryDetails.$RAMSerialNumber -and $RAMDetails[$i].Capacity -eq $RegistryDetails.$RAMCapacity)
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
    if ($RAMDetails.Manufacturer -eq $RegistryDetails.RAMManufacturer -and $RAMDetails.SerialNumber -eq $RegistryDetails.RAMSerialNumber -and $RAMDetails.Capacity -eq $RegistryDetails.RAMCapacity)
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

