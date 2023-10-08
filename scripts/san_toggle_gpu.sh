#!/usr/bin/env bash

if [[ $(id -u) != 0 ]]; then
  sudo $0
  exit 0
fi

lspci | grep 01:00.0 > /dev/zero
status=$?

if [[ $status == 0 ]]; then
  echo "Unbinding GPU..."
  modprobe -r nvidia-drm
  modprobe -r nvidia
  if [[ $? != 0 ]]; then
    echo "Unable to unbind GPU becouse it is in use!"
    exit 1
  fi
  echo 1 > /sys/bus/pci/devices/0000:01:00.0/remove 
  echo 1 > /sys/bus/pci/devices/0000:01:00.1/remove 
  sleep 1
  echo "Done!"
else
  echo "Binding GPU..."
  echo 1 > /sys/bus/pci/rescan
  sleep 1
  echo "Done!"
fi



exit 0
