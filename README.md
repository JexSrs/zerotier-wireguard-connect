# zerotier-wireguard-connect
A simple shell script which will join a predefined ZeroTier network and immediately connect to a Wireguard server.

This script was created because I wanted to have full access to my homelab servers (including the DNS servers) without
exposing the Wireguard port to the internet.

## Prerequisites
- `ZEROTIER_NETWORK_ID`: the ZeroTier network id (can be found in `https://my.zerotier.com`)
- `WIREGUARD_CONFIG`: the path to the Wireguard configuration file.

You will need to have installed the [`zerotier-cli`](https://www.zerotier.com/download/) and [`wireguard-tools`](https://www.wireguard.com/install/).

## How to run

First populate the variables at the top of the `script.sh`.

Make file executable:
```shell
chmod a+x script.sh
```

Execute:
```shell
./script.sh
```
