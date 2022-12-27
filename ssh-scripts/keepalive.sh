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
if [ -f $HOME/.ssh/config ]; then
  # If the config file exists, echo that it is found
  echo "Config file found"
else
  # If the config file does not exist, echo that it is not found
  echo "Config file not found. Creating one for you!"
  # Create the config file
  touch ~/.ssh/config
  # Change the permissions of the config file to 600
  chmod 600 ~/.ssh/config
  
  echo "Config file created"
fi

# Edit the config file to send an opt null package from the client side to the remote ssh server every 60 seconds
echo "Setting the interval to $interval"
echo "Host *" >> ~/.ssh/config
echo "  KeepAlive yes" >> ~/.ssh/config
echo "  ServerAliveInterval $interval" >> ~/.ssh/config
echo "Done!"