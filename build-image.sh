#!/bin/bash

echo ""

echo -e "\nbuild docker hadoop image\n"
sudo docker build -t wentaoma/hadoop:2.7.2 .

echo ""
