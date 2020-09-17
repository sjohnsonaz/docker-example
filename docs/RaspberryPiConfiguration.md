# Raspberry Pi Configuration

## Disable Wireless

First, let's turn off WiFi and Bluetooth

```
sudo systemctl disable wpa_supplicant
sudo systemctl disable bluetooth
sudo systemctl disable hciuart
```

Edit Boot configuration

```
sudo nano /boot/config.txt
```

Add these lines:

```
# Disable WiFi and Bluetooth
dtoverlay=pi3-disable-wifi
dtoverlay=pi3-disable-bt
```

## Set Static IP

Find the ethernet adapter name

```
ifconfig
```

It will likely be either `eth0` or something starting with `enx`.  For example

```
enxb827ebdc0d1f: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
```

Edit DHCP Configuration

```
sudo nano /etc/dhcpcd.conf
```

Add these lines
 
```
interface eth0
static ip_address=192.168.1.[[Your Static IP]]/24
static routers=192.168.1.1
static domain_name_servers=192.168.1.1
```

## Install Docker and Kubernetes

```
#!/bin/sh

# This installs the base instructions up to the point of joining / creating a cluster

curl -sSL get.docker.com | sh && \
  sudo usermod pi -aG docker

sudo dphys-swapfile swapoff && \
  sudo dphys-swapfile uninstall && \
  sudo update-rc.d dphys-swapfile remove

curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add - && \
  echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list && \
  sudo apt-get update -q && \
  sudo apt-get install -qy kubeadm
  
echo Adding " cgroup_enable=cpuset cgroup_memory=1 cgroup_enable=memory" to /boot/cmdline.txt

sudo cp /boot/cmdline.txt /boot/cmdline_backup.txt
orig="$(head -n1 /boot/cmdline.txt) cgroup_enable=cpuset cgroup_memory=1 cgroup_enable=memory"
echo $orig | sudo tee /boot/cmdline.txt

echo Please reboot
```

Or run

```# curl -sL \
 https://gist.githubusercontent.com/alexellis/fdbc90de7691a1b9edb545c17da2d975/raw/b04f1e9250c61a8ff554bfe3475b6dd050062484/prep.sh \
 | sudo sh
```