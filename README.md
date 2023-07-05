# Device-Hardware-Change-Moniter
The Script and Sensors will monitor the device's Hardware components and alerts the admin when there is a change.

Steps:

1. Create a script (create_device_hardware_registry.ps1) in Workspace One UEM.
2. The script creates registries to store the device hardware details (CPU, Memory, HardDisk Disk, GPU, MotherBoard). The script would be executed once during enrollment to capture these details which will be used by sensors to monitor any Hardware changes.

Execution Context & Privileges: System Context
Execution Architecture: Auto
Timeout: 60
Assignment Trigger: Run once immediately

3. Create sensors that run periodically to check the current hardware type & configurations, and compare them with the previous registry. Validate if there is any change in the value and report back in UEM.

4. Create individual sensors for different hardware components.

5. Create a Dashboard in Intelligence for monitoring.

6. Create Freestyle in Intelligence to alert the admin if there is a change.
![image](https://github.com/gvinodh1/Device-Hardware-Change-Moniter/assets/33771537/dcb4a6b1-3814-4ee6-8c60-c66bb7eb8bfc)

