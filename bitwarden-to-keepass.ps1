# MICROSOFT WINDOWS POWER SHELL SCRIPT

# INSTRUCTIONS
# 1. Install Python for Windows
# 2. Download the latest Bitwarden CLI executable and place in a sub-folder folder named: bitwardencli
# 3. Optional: Edit the configuration below to set different hosts, key files or output folders
# 4. Run this script, no admin rights required

Write-Host "------------------------------------------------------" -ForegroundColor yellow
Write-Host "  Bitwarden to KeePass PowerShell script for Windows  " -ForegroundColor yellow
Write-Host "------------------------------------------------------" -ForegroundColor yellow
Write-Host "`n"

# Set configuration
$BW_PATH="bitwardencli/bw.exe"
$DATABASE_PATH="../"+(get-date -Format "yyyy-MM-dd_HHmmss")+"_bitwarden-export.kdbx"
#$DATABASE_PASSWORD = "secret-password" #If disabled, will prompt for a password at runtime (safer practice)
#$DATABASE_KEYFILE="my_key_file.key" # Optional
#Invoke-Expression "$BW_PATH config server https://your.bw.domain.com" #Self-hosted vault

# Check for the Bitwarden CLI
if ( -Not (Test-Path $BW_PATH))
{
	Write-Host "`nERROR! Could not find required Bitwarden CLI executable in $BW_PATH" -ForegroundColor red 
	Write-Host "`n"
	pause
	exit
}

# Setup the virtual environment and install libraries
#py -m venv .
#Scripts\activate
#py -m pip install setuptools
#py -m pip install -r requirements.txt
pip install --no-cache-dir poetry
& $env:appdata\Python\Scripts\poetry.exe install --no-root

#Unlock and sync the bitwarden vault
Invoke-Expression "$BW_PATH login"
Write-Host "`n"
$BW_SESSION= Invoke-Expression "$BW_PATH unlock --raw"
Write-Host "`n"
Invoke-Expression "$BW_PATH sync"
Write-Host "`n"

# Ask for the new DB password
if (!$DATABASE_PASSWORD) {
$DATABASE_PASSWORD=Read-Host "`nPlease enter the password for KeePass DB: "}

# Perform the backup
Write-Host "`n"
#py bitwarden-to-keepass.py --bw-session $BW_SESSION --database-path $DATABASE_PATH --database-password $DATABASE_PASSWORD --database-keyfile $DATABASE_KEYFILE --bw-path $BW_PATH
poetry run py bitwarden-to-keepass.py --bw-session $BW_SESSION --database-path $DATABASE_PATH --database-password $DATABASE_PASSWORD --database-keyfile $DATABASE_KEYFILE --bw-path $BW_PATH

# Lock the vault
Invoke-Expression "$BW_PATH lock"

# Unset sensitive variables
Remove-Variable DATABASE_PASSWORD
Remove-Variable BW_SESSION

Write-Host "`n"
Write-Host "`nDONE!" -ForegroundColor blue
Write-Host "`n"

pause