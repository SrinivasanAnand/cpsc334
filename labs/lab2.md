<h1>Lab 2: 9/14/23 - Anand Srinivasan Darwin Do</h1>
Manual SCP from Pi -> laptop:

* Finding the IP address of Darwin’s laptop with `ifconfig` was really easy as he only had 2 network interface cards on his laptop. Anand’s Macbook contained 10+ NICs and we had to manually look through them until we found something that looked right. (Later found an alternate quick way to access ip in network settings).
* We both had to enable ssh on our laptops
  * Darwin: Enabled sshd daemon with `systemctl enable sshd`
  * Anand: Enabled SSH in Mac settings
* We had to copy the Pi’s public SSH key generated in the last lab to our laptop’s authorized_keys file
* Steps for sending files from Pi to Laptop using SCP:
  * Find IP of laptop and host username to send file to
  * Ensure that the Pi’s public SSH key is in host’s authorized_keys
  * Use SCP to copy file over
    * Syntax: `scp file_name host_username@hostip:<path_to_write_file>`
  * To automatically perform this task, the above command can be written in a bash file and regularly scheduled with cron or some other timer service

Bash script to copy ip.md -> laptop takeaways:
* We used https://crontab.guru/ to “read” our cron schedule before testing

Disabling 10-minute push cycle:
* We weren’t a fan the 10-minute push workflow because this requires hardcoding the IP of your development device into the Pi script which can be unstable. We prefer the method of pushing the Pi’s IP address to Github on boot as all that requires is for the Pi to have a working internet connection on boot

Darwin’s Update fiasco:
* In an attempt to install a newer version of vim on the Pi, Darwin ran a `sudo apt-get full-upgrade` to fully upgrade his system. Upon reboot, his networking drivers failed to load the wlan0 interface and no amount of network service tweaking could bring it back. The decision was made to fully re-image the Pi which was done on a later date.
