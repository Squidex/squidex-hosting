#!/bin/bash

## Run setup script in parallel
sh /opt/setup.sh &

## Running server
source /opt/deepdetect/start-dede.sh -host "0.0.0.0"