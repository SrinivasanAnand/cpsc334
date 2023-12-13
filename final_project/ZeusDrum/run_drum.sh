#!/bin/bash

cd ~/cpsc334/final_project/ZeusDrum/
python3 drum_osc.py &
cd osc_beats
python3 drum_server.py

echo "finished"
#sleep 10
#sudo shutdown

