#!/bin/bash

until $(curl --output /dev/null --silent --get --fail http://localhost:8080/info); do
    printf '.'
    sleep 5
done
# Create service
echo "Creating service"

curl -X PUT 'http://localhost:8080/services/squidexdetector' -d '{
    "description": "image classification service",
    "mllib": "caffe",
    "model": {
        "init": "https://deepdetect.com/models/init/desktop/images/classification/ilsvrc_googlenet.tar.gz",
        "repository": "/opt/models/ilsvrc_googlenet",
    "create_repository": true
    },
    "parameters": {
        "input": {
            "connector": "image"
        }
    },
    "type": "supervised"
}
'
