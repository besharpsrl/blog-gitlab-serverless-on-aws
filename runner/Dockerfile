FROM ubuntu:20.04 
 
# Ubuntu based GitLab runner with nodeJS, npm, and aws CLI 
# --------------------------------------------------------------------- 
# Install https://github.com/krallin/tini - a very small 'init' process 
# that helps process signals sent to the container properly. 
# --------------------------------------------------------------------- 
ARG TINI_VERSION=v0.19.0 
 
COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh 
 
RUN ln -snf /usr/share/zoneinfo/Europe/Rome /etc/localtime && echo Europe/Rome > /etc/timezone \ 
   && echo "Installing base packaes" \ 
   && apt update && apt install -y curl gnupg unzip jq software-properties-common \ 
   && echo "Installing packages" \ 
   && apt install -y unzip openssh-server ca-certificates git git-lfs nodejs npm \ 
   && echo "Installing tini and ssh" \ 
   && curl -Lo /usr/local/bin/tini https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini-amd64 \ 
   && chmod +x /usr/local/bin/tini \ 
   && mkdir -p /run/sshd \ 
   && curl -L https://packages.gitlab.com/install/repositories/runner/gitlab-runner/script.deb.sh | bash \ 
       && apt install -y gitlab-runner \ 
       && rm -rf /var/lib/apt/lists/* \ 
       && rm -f /home/gitlab-runner/.bash_logout \
   && git lfs install --skip-repo \ 
   && chmod +x /usr/local/bin/docker-entrypoint.sh \ 
   && echo "Done"

ENTRYPOINT ["tini", "--", "/usr/local/bin/docker-entrypoint.sh"]

