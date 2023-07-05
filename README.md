# Device-Hardware-Change-Moniter
The Script and Sensors will monitor the device's Hardware components and alerts the admin when there is a change.

Steps:

1. Create a script (create_device_hardware_registry.ps1) in Workspace One UEM: The script creates registries to store the device hardware details (CPU, Memory, HardDisk Disk, GPU, MotherBoard). The script would be executed once during enrollment to capture these details which will be used by sensors to monitor any Hardware changes.

  -Execution Context & Privileges: System Context
  -Execution Architecture: Auto
  -Timeout: 60
  -Assignment Trigger: Run once immediately

2. Create sensors (check_cpu_hardware.ps1, check_gpu_hardware.ps1, check_harddisk_hardware.ps1, check_motherboard_hardware.ps1, check_ram_hardware.ps1) in Workspace One UEM: These sensors run periodically to check the current device hardware details and compare them with the previous registry. And validates if there is any change in the value and report back in UEM.

3. Create a Dashboard with Widgets and sensors to monitor the hardware change in the inventory. (Import the Dashboard from the folder)

4. Create Freestyle in Intelligence to tag the device and alert the admin via email if there is a change in Hardware.
![image](https://github.com/gvinodh1/Device-Hardware-Change-Moniter/assets/33771537/ee9af984-f734-4f88-ab45-b562b2c2f3b4)

