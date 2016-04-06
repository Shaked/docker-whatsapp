#!/bin/bash
docker-machine create --driver virtualbox whatsapp
docker-machine env whatsapp
eval "$(docker-machine env whatsapp)"
docker build -t whatsapp .