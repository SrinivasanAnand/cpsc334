
#!/bin/bash

cd /home/student334/cpsc334/raspberrypi

hostname -I > ip.md

git add ip.md
git commit -m "update ip"
git push

