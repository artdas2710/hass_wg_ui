#!/bin/bash

# Read options from options.json
wg_host=$(jq --raw-output '.wg_host' /data/options.json)
password=$(jq --raw-output '.password' /data/options.json)

docker run -d \
  --name=wg-easy \
  -e WG_HOST=${wg_host} \
  -e PASSWORD=${password} \
  -v ~/.wg-easy:/etc/wireguard \
  -p 51820:51820/udp \
  -p 51821:51821/tcp \
  --cap-add=NET_ADMIN \
  --cap-add=SYS_MODULE \
  --sysctl="net.ipv4.conf.all.src_valid_mark=1" \
  --sysctl="net.ipv4.ip_forward=1" \
  --restart unless-stopped \
  ghcr.io/wg-easy/wg-easy

# Keep the script running to prevent the container from stopping
tail -f /dev/null