FROM ubuntu:20.04 
 
ARG GITLAB_TOKEN 
ARG RUNNER_TAGS 
ARG GITLAB_URL="https://gitlab.com" 
ARG SUBNET
ARG SECURITY_GROUP_ID 
 
 
COPY config.toml /tmp/ 
COPY ecs.toml /tmp/ 
COPY entrypoint / 
 
 
RUN apt update && apt install -y curl unzip \ 
       && curl -L https://packages.gitlab.com/install/repositories/runner/gitlab-runner/script.deb.sh | bash \ 
       && apt install -y gitlab-runner \ 
       && rm -rf /var/lib/apt/lists/* \ 
       && rm -f "/home/gitlab-runner/.bash_logout" \ 
       && chmod +x /entrypoint \ 
       && mkdir -p /opt/gitlab-runner/metadata /opt/gitlab-runner/builds /opt/gitlab-runner/cache \ 
       && curl -Lo /opt/gitlab-runner/fargate https://gitlab-runner-custom-fargate-downloads.s3.amazonaws.com/latest/fargate-linux-amd64 \ 
       && chmod +x /opt/gitlab-runner/fargate \ 
       && RUNNER_TASK_TAGS=$(echo ${RUNNER_TAGS} | tr "," "-") \ 
       && sed -i s/RUNNER_TAGS/${RUNNER_TASK_TAGS}/g /tmp/ecs.toml \ 
       && sed -i s/SUBNET/${SUBNET}/g /tmp/ecs.toml \ 
       && sed -i s/SECURITY_GROUP_ID/${SECURITY_GROUP_ID}/g /tmp/ecs.toml \ 
       && cp /tmp/ecs.toml /etc/gitlab-runner/ \ 
       && echo "Token: ${GITLAB_TOKEN} url: ${GITLAB_URL} Tags: ${RUNNER_TAGS}" \ 
       && gitlab-runner register \ 
               --non-interactive \ 
               --url ${GITLAB_URL} \ 
               --registration-token ${GITLAB_TOKEN} \ 
               --template-config /tmp/config.toml \ 
               --description "GitLab runner for ${RUNNER_TAGS}" \ 
               --executor "custom" \ 
               --tag-list ${RUNNER_TAGS} 
 
ENTRYPOINT ["/entrypoint"] 
CMD ["run", "--user=gitlab-runner", "--working-directory=/home/gitlab-runner"]
