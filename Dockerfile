# Docker-version 1.0
FROM databricksruntime/minimal:latest

RUN apt-get update \
  && apt-get install --yes openssh-server \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
  && mkdir ~/.ssh \
  && mv id_rsa ~/.ssh/ \
  && echo "StrictHostKeyChecking no" >> /etc/ssh/ssh_config \
  && cat /etc/ssh/ssh_config \
  && chmod go-w /root \
  && chmod 700 /root/.ssh \
  && chmod 600 /root/.ssh/id_rsa \
  && ssh-add ~/.ssh/id_rsa 

# Warning: the created user has root permissions inside the container
# Warning: you still need to start the ssh process with `sudo service ssh start`

RUN sudo service ssh start
RUN useradd --create-home --shell /bin/bash --groups sudo ubuntu
EXPOSE 2200
