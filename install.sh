#!/usr/bin/env sh
# Copyleft (c) Abhiram Shibu 2022

echo "Checking if LG Module is present"
lsmod | grep lg_laptop > /dev/null
if [ $? -ne 0 ]
then
	echo "It seems lg_laptop driver is not loaded, testing for modules inside kernel"
	if [ ! -d "/sys/devices/platform/lg-laptop" ]
		then
		echo "Unable to find driver directory /sys/devices/platform/lg-laptop"
		echo "Exiting installation, you might not have a lg-laptop which supports this"
		exit -1
	else
		echo "Found driver directory"
	fi
else
	echo "Success, found lg_laptop driver"
fi

echo "Its time to test if I have root access"
if [ $EUID -ne 0 ]
then
	echo "Oops! I don't seems to have root access, please run me with sudo or as root *_*"
else
	echo "Ok, alright then, installing."
	sudo install lg-battery-limit.service /etc/systemd/system
	echo "Installed!"
	echo "You can edit the limit by editing echo parameter in ExecStart"
	echo "sudo systemctl --edit --full lg-battery-limit.service"
fi
echo "Done"
