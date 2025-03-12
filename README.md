# Cloudflared Tunnel

## Description

This script is a modified version of the original script for running [Cloudflare Tunnel](https://github.com/Ym0T/pterodactyl-nginx-egg). Originally created by [Ym0t](https://github.com/Ym0T), the script has been modified by [HHakeRR785](https://github.com/HHakeRR785) to provide an easier way to run [Cloudflared](https://github.com/cloudflare/cloudflared) in containers or on servers.

The script automatically checks if `cloudflared` is installed, downloads the latest version if needed, starts the tunnel using a token, and monitors the connection status.

## Features

- Checks if `cloudflared` is installed. If not, it downloads the latest version.
- Starts the Cloudflared tunnel using the token saved in the `cloudflared_token.txt` file.
- Monitors the connection status, logging any errors and successes in the logs.
- Provides an easy setup and tunnel launch for containers or servers.

## Installation

1. Ensure you have `git` installed and the necessary permissions to execute files on your system.
2. Create a new Pterodactyl egg and configure it to run the following installation process.
3. In the egg setup, make sure the script will download the repository from GitHub at server installation. You can do this by adding the following lines to your Pterodactyl egg's `install` configuration:

```bash
# Create necessary folders
echo -e "[SETUP] Create folders"
mkdir -p logs tmp

# Clone the repository into a temporary directory and extract it
echo "[Git] Cloning default repository 'https://github.com/BlackHost-PL/Cloudflared' into temporary directory."
git clone https://github.com/BlackHost-PL/Cloudflared /mnt/server/gtemp > /dev/null 2>&1 && echo "[Git] Repository cloned successfully." || { echo "[Git] Error: Default repository clone failed."; exit 21; }
cp /mnt/server/gtemp/cloudflared.sh /mnt/server || { echo "[Git] Error: Copying 'cloudflared.sh' file failed."; exit 22; }
cp /mnt/server/gtemp/LICENSE /mnt/server || { echo "[Git] Error: Copying 'LICENSE' file failed."; exit 22; }
chmod +x /mnt/server/cloudflared.sh
```

4. Modify the start command in your Pterodactyl egg to automatically execute the script on server start.

### Requirements

- Linux-based operating system (script tested on AMD64-based systems).
- `git` must be installed on your container.

## Configuration

The script requires the `cloudflared_token.txt` file, which contains the token for tunnel authorization. You can generate the token through Cloudflare.

1. Go to the [Cloudflare Dashboard](https://dash.cloudflare.com/).
2. Create a new tunnel in the **Zero Trust** section (Cloudflare for Teams).
3. Download the token and save it in the `cloudflared_token.txt` file in the same directory as the script.

## Authors

- **Original script**: [Ym0t](https://github.com/Ym0T)
- **Modified script**: [HHakeRR785](https://github.com/HHakeRR785)

## License

[MIT License](https://choosealicense.com/licenses/mit/)

Original repository: https://gitlab.com/tenten8401/pterodactyl-nginx