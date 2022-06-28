#!/bin/bash

docker build . -t gitlab-runner

# Don't forget to include docker push for you ECR repository