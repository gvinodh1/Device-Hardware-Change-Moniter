<#
  Name: create_device_hardware_registry
  Version: 1.0
  Created: July, 2023
  Created By: Vinodh G gvinodh@vmware.com
  Description: The script creates registries to store the device hardware details (of CPU, Memory, HardDisk Disk, GPU, MotherBoard, Battery). The script would be executed only once during enrollment to capture all these details which will be used by Sensors to Monitor any Hardware changes.
  Execution Context: System
  Execution Architecture: Auto
  Script: The script would be executed during enrollment to capture the details of Hardware which will be used by Sensors to Monitor any Hardware changes.
#>

##############################################################################

#Create registry to store Device Hardware details initially.
if (!(Test-Path -LiteralPath 'HKLM:\SOFTWARE\VMware, Inc.\Workspace One\Device Hardware details'))
{
 New-Item 'HKLM:\SOFTWARE\VMware, Inc.\Workspace One\Device Hardware details' -Force
}

#Capture RAM details
$RAMDetails = Get-CimInstance -Class CIM_PhysicalMemory

if ($RAMDetails.Count -gt 1)
{
Set-ItemProperty 'HKLM:\SOFTWARE\VMware, Inc.\Workspace One\Device Hardware details' -Name 'RAM_Count' -Value $RAMDetails.Count
for ($i=0; $i -lt $RAMDetails.Count; $i++)
{
Set-ItemProperty 'HKLM:\SOFTWARE\VMware, Inc.\Workspace One\Device Hardware details' -Name $i-RAMManufacturer -Value $RAMDetails[$i].Manufacturer 
Set-ItemProperty 'HKLM:\SOFTWARE\VMware, Inc.\Workspace One\Device Hardware details' -Name $i-RAMSerialNumber -Value $RAMDetails[$i].SerialNumber
Set-ItemProperty 'HKLM:\SOFTWARE\VMware, Inc.\Workspace One\Device Hardware details' -Name $i-RAMCapacity -Value $RAMDetails[$i].Capacity
}
}
else
{
Set-ItemProperty 'HKLM:\SOFTWARE\VMware, Inc.\Workspace One\Device Hardware details' -Name RAMManufacturer -Value $RAMDetails.Manufacturer
Set-ItemProperty 'HKLM:\SOFTWARE\VMware, Inc.\Workspace One\Device Hardware details' -Name RAMSerialNumber -Value $RAMDetails.SerialNumber
Set-ItemProperty 'HKLM:\SOFTWARE\VMware, Inc.\Workspace One\Device Hardware details' -Name RAMCapacity -Value $RAMDetails.Capacity
}

#Capture CPU details
$CPUDetails = Get-CimInstance -ClassName Win32_Processor

if ($CPUDetails.Count -gt 1)
{
Set-ItemProperty 'HKLM:\SOFTWARE\VMware, Inc.\Workspace One\Device Hardware details' -Name 'CPU_Count' -Value $CPUDetails.Count
for ($i=0; $i -lt $CPUDetails.Count; $i++)
{
Set-ItemProperty 'HKLM:\SOFTWARE\VMware, Inc.\Workspace One\Device Hardware details' -Name $i-CPUNumberOfCores -Value $CPUDetails[$i].NumberOfCores
Set-ItemProperty 'HKLM:\SOFTWARE\VMware, Inc.\Workspace One\Device Hardware details' -Name $i-CPUName -Value $CPUDetails[$i].Name
Set-ItemProperty 'HKLM:\SOFTWARE\VMware, Inc.\Workspace One\Device Hardware details' -Name $i-CPUProcessorId -Value $CPUDetails[$i].ProcessorId
Set-ItemProperty 'HKLM:\SOFTWARE\VMware, Inc.\Workspace One\Device Hardware details' -Name $i-CPUManufacturer -Value $CPUDetails[$i].Manufacturer
}
}
else
{
Set-ItemProperty 'HKLM:\SOFTWARE\VMware, Inc.\Workspace One\Device Hardware details' -Name CPUNumberOfCores -Value $CPUDetails.NumberOfCores
Set-ItemProperty 'HKLM:\SOFTWARE\VMware, Inc.\Workspace One\Device Hardware details' -Name CPUName -Value $CPUDetails.Name
Set-ItemProperty 'HKLM:\SOFTWARE\VMware, Inc.\Workspace One\Device Hardware details' -Name CPUProcessorId -Value $CPUDetails.ProcessorId
Set-ItemProperty 'HKLM:\SOFTWARE\VMware, Inc.\Workspace One\Device Hardware details' -Name CPUManufacturer -Value $CPUDetails.Manufacturer
}

#Capture HardDisk details
$HarddiskDetails = Get-PhysicalDisk

if ($HarddiskDetails.Count -gt 1)
{
Set-ItemProperty 'HKLM:\SOFTWARE\VMware, Inc.\Workspace One\Device Hardware details' -Name 'HardDisk_Count' -Value $HarddiskDetails.Count
for ($i=0; $i -lt $HarddiskDetails.Count; $i++)
{
Set-ItemProperty 'HKLM:\SOFTWARE\VMware, Inc.\Workspace One\Device Hardware details' -Name $i-HardDiskSerialNumber -Value $HarddiskDetails[$i].SerialNumber
Set-ItemProperty 'HKLM:\SOFTWARE\VMware, Inc.\Workspace One\Device Hardware details' -Name $i-HardDiskName -Value $HarddiskDetails[$i].FriendlyName
Set-ItemProperty 'HKLM:\SOFTWARE\VMware, Inc.\Workspace One\Device Hardware details' -Name $i-HardDiskSize -Value $HarddiskDetails[$i].Size
Set-ItemProperty 'HKLM:\SOFTWARE\VMware, Inc.\Workspace One\Device Hardware details' -Name $i-HardDiskType -Value $HarddiskDetails[$i].MediaType
}
}
else
{
Set-ItemProperty 'HKLM:\SOFTWARE\VMware, Inc.\Workspace One\Device Hardware details' -Name HardDiskSerialNumber -Value $HarddiskDetails.SerialNumber
Set-ItemProperty 'HKLM:\SOFTWARE\VMware, Inc.\Workspace One\Device Hardware details' -Name HardDiskName -Value $HarddiskDetails.FriendlyName
Set-ItemProperty 'HKLM:\SOFTWARE\VMware, Inc.\Workspace One\Device Hardware details' -Name HardDiskSize -Value $HarddiskDetails.Size
Set-ItemProperty 'HKLM:\SOFTWARE\VMware, Inc.\Workspace One\Device Hardware details' -Name HardDiskType -Value $HarddiskDetails.MediaType
}

#Capture GPU details
$GPUDetails = Get-WmiObject win32_VideoController

if ($GPUDetails.Count -gt 1)
{
Set-ItemProperty 'HKLM:\SOFTWARE\VMware, Inc.\Workspace One\Device Hardware details' -Name 'GPU_Count' -Value $GPUDetails.Count
for ($i=0; $i -lt $GPUDetails.Count; $i++)
{
Set-ItemProperty 'HKLM:\SOFTWARE\VMware, Inc.\Workspace One\Device Hardware details' -Name $i-GPUName -Value $GPUDetails[$i].Name
Set-ItemProperty 'HKLM:\SOFTWARE\VMware, Inc.\Workspace One\Device Hardware details' -Name $i-GPUAdapterRAMSize -Value $GPUDetails[$i].AdapterRAM
Set-ItemProperty 'HKLM:\SOFTWARE\VMware, Inc.\Workspace One\Device Hardware details' -Name $i-GPUVideoProcessor -Value $GPUDetails[$i].VideoProcessor
}
}
else
{
Set-ItemProperty 'HKLM:\SOFTWARE\VMware, Inc.\Workspace One\Device Hardware details' -Name GPUName -Value $GPUDetails.Name
Set-ItemProperty 'HKLM:\SOFTWARE\VMware, Inc.\Workspace One\Device Hardware details' -Name GPUAdapterRAMSize -Value $GPUDetails.AdapterRAM
Set-ItemProperty 'HKLM:\SOFTWARE\VMware, Inc.\Workspace One\Device Hardware details' -Name GPUVideoProcessor -Value $GPUDetails.VideoProcessor
}

#Capture Mother Board details
$MotherBoardDetails = Get-WmiObject win32_baseboard

if ($MotherBoardDetails.Count -gt 1)
{
Set-ItemProperty 'HKLM:\SOFTWARE\VMware, Inc.\Workspace One\Device Hardware details' -Name 'MotherBoard_Count' -Value $MotherBoardDetails.Count
for ($i=0; $i -lt $MotherBoardDetails.Count; $i++)
{
Set-ItemProperty 'HKLM:\SOFTWARE\VMware, Inc.\Workspace One\Device Hardware details' -Name $i-MotherBoardManufacturer -Value $MotherBoardDetails[$i].Manufacturer
Set-ItemProperty 'HKLM:\SOFTWARE\VMware, Inc.\Workspace One\Device Hardware details' -Name $i-MotherBoardName -Value $MotherBoardDetails[$i].Name
Set-ItemProperty 'HKLM:\SOFTWARE\VMware, Inc.\Workspace One\Device Hardware details' -Name $i-MotherBoardSerialNumber -Value $MotherBoardDetails[$i].SerialNumber
}
}
else
{
Set-ItemProperty 'HKLM:\SOFTWARE\VMware, Inc.\Workspace One\Device Hardware details' -Name MotherBoardManufacturer -Value $MotherBoardDetails.Manufacturer
Set-ItemProperty 'HKLM:\SOFTWARE\VMware, Inc.\Workspace One\Device Hardware details' -Name MotherBoardName -Value $MotherBoardDetails.Name
Set-ItemProperty 'HKLM:\SOFTWARE\VMware, Inc.\Workspace One\Device Hardware details' -Name MotherBoardSerialNumber -Value $MotherBoardDetails.SerialNumber
}


