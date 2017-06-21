#!/bin/bash
#################
# uberscan3x.sh #
#################
#
# 3x ubertooth setup and simultaneous data capturing tool script that quickly manages 
# all the necessary steps to obtain a setup capable of capturing the full advertising 
# spectrum of bluetooth low energy (3 advertising channels, 3 ubertooth devices required).
# Please, use this script under Kali with root privileges. Not tested in any other environment.

echo "Uberscan3x.sh - Ubertooth 3X BTLE capture automation script - Eurecat IT Security"
echo 
echo "Please, ensure that you have 3 ubertooth devices connected before proceeding."
echo "Then press enter."
read foo
echo "OK. Proceeding..."
echo -n "Step 1 - Creating named pipes..."
mkfifo /tmp/ubertooth1
mkfifo /tmp/ubertooth2
mkfifo /tmp/ubertooth3
echo "completed."
ls /tmp/ubertooth?
sleep 2
echo -n "Step 2 - Launching ubertooth-btle instances linked to pipes (separate xterms)..."
xterm -hold -e "ubertooth-btle -U0 -A37 -f -c /tmp/ubertooth1" &
xterm -hold -e "ubertooth-btle -U1 -A38 -f -c /tmp/ubertooth2" &
xterm -hold -e "ubertooth-btle -U2 -A39 -f -c /tmp/ubertooth3" &
echo "completed."
echo "Launching wireshark instance to capture data from pipes. Capture will start automatically..."
wireshark -k -i /tmp/ubertooth1 -i /tmp/ubertooth2 -i /tmp/ubertooth3 &
sleep 2
echo "Press enter when ready in order to end and clean up."
read foo
echo "Cleaning up processess and removing pipes..."
killall ubertooth-btle
rm -rf /tmp/ubertooth?
echo "completed."
echo "Bye!"


