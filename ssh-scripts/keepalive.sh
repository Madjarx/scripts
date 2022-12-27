#!/bin/bash

# Example usage 
# ./keepalive.sh 90  - if you want to set your own interval
# ./keepalive.sh  - if you want to go with the default interval of 60 seconds 

# Set the default value for the interval to 60 seconds
interval=60

# Check if an interval was passed as an argument
while [[ $# -gt 0 ]]
do
  key="$1"
  case $key in
    -i|--interval)
      interval="$2"
      shift # past argument
      shift # past value
      ;;
    *)    # unknown option
      shift # past argument
      ;;
  esac
done


# Check if the config file exists in the .ssh directory
if [ -f ~/.ssh/config ]; then
  echo "Config file found! Overriding value"
  # If the config file exists, modify it to send an opt null package from the client side to the remote ssh server every 60 seconds
  sed -i '/ServerAliveInterval/d' ~/.ssh/config
  echo "Host *" >> ~/.ssh/config
  echo "  KeepAlive yes" >> ~/.ssh/config
  echo "  ServerAliveInterval $interval" >> ~/.ssh/config
else
  # If the config file does not exist, echo that it is not found
  echo "config file not found. Creating one for you!"
  # Create the config file
  touch ~/.ssh/config
  # Change the permissions of the config file to 600
  chmod 600 ~/.ssh/config
  # Edit the config file to send an opt null package from the client side to the remote ssh server every 60 seconds
  echo "Writing Values!"
  echo "Host *" >> ~/.ssh/config
  echo "  KeepAlive yes" >> ~/.ssh/config
  echo "  ServerAliveInterval $interval" >> ~/.ssh/config
fi

echo "Done!"