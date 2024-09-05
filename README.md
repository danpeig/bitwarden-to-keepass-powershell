# bitwarden-to-keepass-powershell
Export (most of) your Bitwarden items into KeePass (kdbx) database. That includes logins - with TOTP seeds, URIs, custom fields, attachments and secure notes.
This runs natively from Windows, it does not require Linux or Docker.

## How it works?
It uses official [bitwarden-cli](https://bitwarden.com/help/article/cli/) client to export your items from Bitwarden vault and move them into your KeePass database - that includes logins (with TOTP seeds, URIs, custom fields, attachments, notes) and secure notes.

This code was derived from [bitwarden-to-keepass](https://github.com/davidnemec/bitwarden-to-keepass). The original tool was intended to run as a Docker container or from Linux taking several GB from your Windows partition just for the runtime payload. This approach, using a PowerShell script, is much simpler and light.

## Requirements
- Microsoft Windows
- [Python 3 for Windows](https://www.python.org/downloads/) with PIP (Python Package Installer)
- [Bitwarden CLI](https://github.com/bitwarden/clients/releases)

## Instructions
- Clone this repository (or download all files)
- Make sure you have Python 3 installed
- Download [bitwarden-cli](https://bitwarden.com/help/article/cli/) and extract to the script root folder (same as the `.ps1` file).
- Optional: Edit `bitwarden-to-keepass.ps1` and configure paths, passwords and key files.
- Run `bitwarden-to-keepass.ps1` and follow the instructions

## Support
This tool uses the Python scripts from [bitwarden-to-keepass](https://github.com/davidnemec/bitwarden-to-keepass) without any modifications. If you have any problems with recent versions of Bitwarden, try grabing the latest versions of the *py* files from that repository.
