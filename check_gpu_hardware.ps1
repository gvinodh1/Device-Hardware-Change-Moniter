<#
  Name: check_gpu_hardware
  Version: 1.0
  Created: July, 2023
  Created By: Vinodh G gvinodh@vmware.com
  Description: This Sensor compares the existing GPU hardware details with the registry values and returns if there is a change in the GPU hardware.
  Execution Context: System
  Execution Architecture: Auto
  Response Type: String
  Script: Sensor to check the current GPU details and compare the existing registry values.
#>

##############################################################################

$RegistryDetails = Get-ItemProperty -Path 'HKLM:\SOFTWARE\VMware, Inc.\Workspace One\Device Hardware details'

$GPUDetails = Get-WmiObject win32_VideoController

if ($GPUDetails.Count -gt 1)
{
    if ($GPUDetails.Count -eq $RegistryDetails.GPU_Count)
    {
        for ($i=0; $i -lt $GPUDetails.Count; $i++)
        {
            $GPUAdapterRAMSize = "$i-GPUAdapterRAMSize"
            $GPUName = "$i-GPUName"
            $GPUVideoProcessor = "$i-GPUVideoProcessor"
            if ($GPUDetails[$i].AdapterRAM -eq $RegistryDetails.$GPUAdapterRAMSize -and $GPUDetails[$i].Name -eq $RegistryDetails.$GPUName -and $GPUDetails[$i].VideoProcessor -eq $RegistryDetails.$GPUVideoProcessor)
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
    if ($GPUDetails.AdapterRAM -eq $RegistryDetails.GPUAdapterRAMSize -and $GPUDetails.Name -eq $RegistryDetails.GPUName -and $GPUDetails.VideoProcessor -eq $RegistryDetails.GPUVideoProcessor)
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

