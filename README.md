# Proton Bridge Container
## Description
This is a container build of [Proton-Bridge](https://github.com/ProtonMail/proton-bridge). The Proton Bridge application is built  from source in no-gui mode and is intended to be used as a mail-server sidecar for other containerized workloads.

## Example
```
podman run -d \
  --name proton-bridge \
  --env USERNAME=proton_username \
  --env PASSWORD=proton_password \
  --env 2FA_CODE=proton_2fa \
  --env KEYRING_PASSPHRASE=keyring_passphrase \
  --volume /path/to/proton/config:/root/.config/protonmail/bridge-v3 \
  --volume /path/to/proton/data:/root/.local/share \
  ghcr.io/hluengas/proton-bridge-container:latest
```

## Env Variables
The following environment variables should be defined:
* **USERNAME**
	* Proton Account Username
* **PASSWORD**
	* Proton Account Password
* **2FA_CODE**
	* Proton Account 2FA Code
* **KEYRING_PASSPHRASE**
	* Password used to unlock the gnome-keyring which stores the proton account login token

## Volume Mounts
* Proton Config Mount
	* stores proton config
	* container path: /root/.config/protonmail/bridge-v3
* Proton Data Mount
	* stores proton vault and login keyring
	* container path: /root/.local/share