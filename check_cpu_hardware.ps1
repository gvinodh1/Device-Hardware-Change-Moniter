<#
  Name: check_cpu_hardware
  Version: 1.0
  Created: July, 2023
  Created By: Vinodh G gvinodh@vmware.com
  Description: This Sensor compares the existing CPU hardware details with the registry values and returns if there is a change in the CPU hardware.
  Execution Context: System
  Execution Architecture: Auto
  Response Type: String
  Script: Sensor to check the current CPU details and compare the existing registry values.
#>

##############################################################################

$RegistryDetails = Get-ItemProperty -Path 'HKLM:\SOFTWARE\VMware, Inc.\Workspace One\Device Hardware details'

$CPUDetails = Get-CimInstance -ClassName Win32_Processor

if ($CPUDetails.Count -gt 1)
{
    if ($CPUDetails.Count -eq $RegistryDetails.CPU_Count)
    {
        for ($i=0; $i -lt $CPUDetails.Count; $i++)
        {
            $CPUManufacturer = "$i-CPUManufacturer"
            $CPUName = "$i-CPUName"
            $CPUNumberOfCores = "$i-CPUNumberOfCores"
            $CPUProcessorId = "$i-CPUProcessorId"
            if ($CPUDetails[$i].Manufacturer -eq $RegistryDetails.$CPUManufacturer -and $CPUDetails[$i].Name -eq $RegistryDetails.$CPUName -and $CPUDetails[$i].NumberOfCores -eq $RegistryDetails.$CPUNumberOfCores -and $CPUDetails[$i].ProcessorId -eq $RegistryDetails.$CPUProcessorId)
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
    if ($CPUDetails.Manufacturer -eq $RegistryDetails.CPUManufacturer -and $CPUDetails.Name -eq $RegistryDetails.CPUName -and $CPUDetails.NumberOfCores -eq $RegistryDetails.CPUNumberOfCores -and $CPUDetails.ProcessorId -eq $RegistryDetails.CPUProcessorId)
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

