# Docker-version 1.0

FROM databricksruntime/minimal:latest

RUN apt-get update 
RUN apt-get install --yes openssh-server 
RUN apt-get clean 
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* 
RUN mkdir ~/.ssh 
RUN mv id_rsa ~/.ssh/ 
RUN echo "StrictHostKeyChecking no" >> /etc/ssh/ssh_config 
RUN cat /etc/ssh/ssh_config 
RUN chmod go-w /root 
RUN chmod 700 /root/.ssh 
RUN chmod 600 /root/.ssh/id_rsa
RUN ssh-add ~/.ssh/id_rsa
RUN git clone https://github.com/prabakar-ammeappin/dcs-ssh

# Warning: the created user has root permissions inside the container
# Warning: you still need to start the ssh process with `sudo service ssh start`

RUN sudo service ssh start
RUN useradd --create-home --shell /bin/bash --groups sudo ubuntu
EXPOSE 2200
