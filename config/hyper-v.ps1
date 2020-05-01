<#
.SYNOPSIS
  Configure a Hyper-V VM
#>
Assert-PowershellAdmin

$vmName = "dev-vm"
$vmPath = "$home/hyper-v"
$vmHddPath = "$vmPath\$vmName.vhdx"
$vmIsoUri = "http://releases.nixos.org/nixos/20.03/nixos-20.03.1619.ab3adfe1c76/nixos-minimal-20.03.1619.ab3adfe1c76-x86_64-linux.iso"

$switchName = "Virtual Hyper-V Switch"
$targetName = "Ethernet"


# Create External switch for VM
$switch = Get-VMSwitch -Name $switchName -ErrorAction SilentlyContinue
if ($switch.Count -EQ 0) {
    New-VMSwitch `
        -Name $switchName `
        -NetAdapterName (Get-NetAdapter -Name $targetName).Name #` -WhatIf
}

# Create VM
$vm = Get-VM -Name $vmName -ErrorAction SilentlyContinue
if ($vm.Count -EQ 0) {
    New-VM `
        -Name $vmName `
        -Path $vmPath `
        -MemoryStartupBytes 2GB `
        -NewVHDPath $vmHddPath `
        -NewVHDSizeBytes 40GB `
        -SwitchName $switchName #` -WhatIf
}

# CPU cores
# Dynamic RAM

# Attach ISO to VM
$isoPath = "C:\Users\andrejus\AppData\Local\Temp\nixos-minimal-20.03.1619.ab3adfe1c76-x86_64-linux.iso" # curlex($vmIsoUri)
Set-VMDvdDrive `
    -VMName $vmName `
    -Path $isoPath #` -WhatIf

# Start VM
Start-VM $vmName
