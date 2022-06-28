#!/bin/bash


# This file builds a runner for autoscaling on ECS. 
# Change values according to you environment (vpc, security groups, GitLab  token)

docker build . -t gitlab-runner-autoscaling --build-arg GITLAB_TOKEN="generatedgitlabtoken" \
    --build-arg RUNNER_TAGS="dev" --build-arg SUBNET="yoursubnetid" \
    --build-arg SECURITY_GROUP_ID="yoursecuritygroupid"

# Don't forget to include docker push for you ECR repository