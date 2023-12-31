<h1>Lab 1: 9/7/23 - Anand Srinivasan Darwin Do</h1>
In order to enable ssh:

* “sudo raspi-config”
* Go to interface options, shh, enable shh

Enable SSH Keys on pi:
* https://pimylifeup.com/raspberry-pi-ssh-keys/
* Used ssh-keygen to generate a pair of public/private keys on our personal computer
* Manually moved the public key contents to the authorized_keys file in ~/.ssh

Generate an SSH key for use with GitHub so you don't need to enter your creds to pull/push [see GitHub docs below] and add to your GitHub keys.
* Use ssh-keygen to create ssh key (do not give key a password)
* Paste key into github (via settings, ssh and gpg keys)
* NOTE: We had to set up our git username/email addresses in the global git config to be able to push correctly with our keys

Bash script to update ip address and push to git:
  #!/bin/bash

  cd /home/student334/cpsc334/raspberrypi

  hostname -I > ip.md

  git add ip.md
  git commit -m "update ip"
  git push

Bash Script Takeways:
* We first accidentally used the “append” (>>) command instead of a standard redirect causing our IP addresses to pile up in the text file.


Call script in /etc/rc.local
* Because we had extra time, we decided to experiment with running our script on boot
* We tried putting an invocation of our script into /etc/rc.local 
  * To access: sudo nano /etc/rc.local
  * But this caused weird permission issues as the system runs commands in /etc/rc.local as root
* We also tried putting an invocation in .bashrc, but found that this caused our script to run at login instead of at boot
