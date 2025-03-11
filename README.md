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

1. Ensure you have `curl` installed and the necessary permissions to execute files on your system.
2. Create a new Pterodactyl egg and configure it to run the following installation process.
3. In the egg setup, make sure the script will download the repository from GitHub at server installation. You can do this by adding the following lines to your Pterodactyl egg's `install` configuration:

```bash
# Download the latest script from GitHub
curl -fsSL -o /home/container/cloudflared_tunnel.sh https://github.com/HHakeRR785/your-repository/raw/main/cloudflared_tunnel.sh && curl -fsSL -o /home/container/LICENSE https://github.com/HHakeRR785/your-repository/raw/main/LICENSE

# Give execute permissions to the script
chmod +x /home/container/cloudflared_tunnel.sh
```

4. Modify the start command in your Pterodactyl egg to automatically execute the script on server start.

### Requirements

- Linux-based operating system (script tested on AMD64-based systems).
- `curl` and `chmod` must be installed on your system.

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
