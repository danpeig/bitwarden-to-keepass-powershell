#-------------------------------------------------------------------------------------------------------------
# MICROSOFT WINDOWS POWER SHELL SCRIPT
# By Daniel B.P. (www.danbp.org)
#-------------------------------------------------------------------------------------------------------------

# INSTRUCTIONS
# 1. Install Python 3 for Windows
# 2. Download the latest Bitwarden CLI executable and place in a sub-folder folder named: bitwardencli
# 3. Optional: Edit the configuration below to set different hosts, key files or output folders
# 4. Run this script, no admin rights required

# Setup the virtual environment and install libraries
py -m venv .
Scripts\activate
py -m pip install -r requirements.txt

#-------------------------------------------------------------------------------------------------------------
# CONFIGURATION SECTION
$BW_PATH="bitwardencli/bw.exe" #This is where the bitwarden CLI executable is
$DATABASE_PATH="exports/"+(get-date -Format "yyyy-MM-dd_HHmmss")+"_bitwarden-export.kdbx" #This is the default name for the database
#$DATABASE_PASSWORD = "secret-password" #If disabled (default), will prompt for a password at runtime
#$DATABASE_KEYFILE="exports/my_keepass.key" # Optional key file
#Invoke-Expression "$BW_PATH config server https://your.bw.domain.com" #Self-hosted vault
#-------------------------------------------------------------------------------------------------------------

# Check for the Bitwarden CLI
if ( -Not (Test-Path $BW_PATH))
{
	Write-Host "ERROR! Could not find required Bitwarden CLI executable in $BW_PATH" -ForegroundColor red 
	exit
}

#Unlock and sync the bitwarden vault
Invoke-Expression "$BW_PATH login"
$BW_SESSION= Invoke-Expression "$BW_PATH unlock --raw"
Invoke-Expression "$BW_PATH sync"

# Ask for the new DB password
if (!$DATABASE_PASSWORD) {
$DATABASE_PASSWORD=Read-Host "`nPlease enter the password for KeePass DB: "}

# Perform the backup
if ($DATABASE_KEYFILE) {
	py bitwarden-to-keepass.py --bw-session $BW_SESSION --database-path $DATABASE_PATH --database-password $DATABASE_PASSWORD --database-keyfile $DATABASE_KEYFILE --bw-path $BW_PATH
}
else {
	py bitwarden-to-keepass.py --bw-session $BW_SESSION --database-path $DATABASE_PATH --database-password $DATABASE_PASSWORD --bw-path $BW_PATH
}


# Lock the vault
Invoke-Expression "$BW_PATH lock"

# Unset sensitive variables
Remove-Variable DATABASE_PASSWORD
Remove-Variable BW_SESSION

pause