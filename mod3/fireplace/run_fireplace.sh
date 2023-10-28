#!/bin/bash

cd /Users/anandsrinivasan/cpsc334/mod3/fireplace
rm log.txt
touch log.txt

cd fireplace_processing
processing-java --sketch=$PWD --run &
cd ..

trap "exit" INT
while [ true ]
do
    python3 esp32_wifi.py >> log.txt
done

