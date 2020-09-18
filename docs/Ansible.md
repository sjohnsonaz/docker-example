# Ansible

## Install Ansible

``` bash
sudo apt update
sudo apt upgrade
sudo apt install ansible
sudo apt install sshpass
```


## Configure Ansible

Go to the configuration directory.

``` bash
cd /etc/ansible
```

Open the hosts file for editing.

``` bash
nano hosts
```

Add the group configuration.

```
[{{ group name }}]
{{ IP Address 1 }}
{{ IP Address 2 }}
{{ ... }}

[{{ group name }}:vars]
ansible_user={{ Username }}
ansible_password={{ Password }}
```

Test the configuration

``` bash
ansible {{ group name }} -m ping
```

## Shutdown
```
ansible {{ group name }} -m shell -a "sudo shutdown -h now"
```

## Reboot
```
ansible {{ group name }} -m shell -a "sudo reboot"
```
