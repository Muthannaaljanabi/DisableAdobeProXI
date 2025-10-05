# Disable Flash Player in Adobe Acrobat Pro XI via Registry
# Applicable for version 11.0; sets bEnableFlash to 0 (disabled)
# Targets both 32-bit (WOW6432Node) and 64-bit registry paths

$RegistryPaths = @(
    "HKLM:\SOFTWARE\WOW6432Node\Policies\Adobe\Acrobat\11.0\FeatureLockDown",
    "HKLM:\SOFTWARE\Policies\Adobe\Acrobat\11.0\FeatureLockDown"
)

$PropertyName = "bEnableFlash"
$PropertyValue = 0

foreach ($RegistryPath in $RegistryPaths) {
    try {
        # Create the registry path if it doesn't exist
        if (-not (Test-Path $RegistryPath)) {
            New-Item -Path $RegistryPath -Force | Out-Null
            Write-Output "Created registry path: $RegistryPath"
        }

        # Set the DWORD value to disable Flash
        Set-ItemProperty -Path $RegistryPath -Name $PropertyName -Value $PropertyValue -Type DWord -Force
        Write-Output "Successfully set $PropertyName to $PropertyValue in $RegistryPath. Flash is now disabled in Acrobat Pro XI."
    }
    catch {
        Write-Error "Failed to update registry path $RegistryPath : $($_.Exception.Message)"
    }
}

exit 0