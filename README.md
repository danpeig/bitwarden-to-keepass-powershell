# bitwarden-to-keepass-powershell
Export (most of) your Bitwarden items into KeePass (kdbx) database. That includes logins - with TOTP seeds, URIs, custom fields, attachments and secure notes.
This runs natively from Windows, it does not require Linux or Docker.

## How it works?
It uses official [bitwarden-cli](https://bitwarden.com/help/article/cli/) client to export your items from Bitwarden vault and move them into your KeePass database - that includes logins (with TOTP seeds, URIs, custom fields, attachments, notes) and secure notes.
This code was derived from [bitwarden-to-keepass](https://github.com/davidnemec/bitwarden-to-keepass). The original code was intended for a Docker container or Linux and I preffer something simpler for Windows.

## Requirements
- Microsoft Windows
- [Python 3 for Windows](https://www.python.org/downloads/)
- [Bitwarden CLI](https://github.com/bitwarden/clients/releases)

## Instructions
- Clone this repository (or download all files)
- Make sure you have Python 3 installed
- Download [bitwarden-cli](https://bitwarden.com/help/article/cli/) and extract to the sub-folder `bitwardencli/bw.exe`.
- Optional: Edit `bitwarden-to-keepass.ps1` and confiugure paths, passwords and key-files
- Run `bitwarden-to-keepass.ps1` and follow the instructions

## Support
This application uses the Python scripts from [bitwarden-to-keepass](https://github.com/davidnemec/bitwarden-to-keepass) without any modifications. If you have any problems with recent versions of Bitwarden, try grabing the latest versions of the *py* files from that repository.
