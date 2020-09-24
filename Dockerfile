FROM ubuntu:18.04
# # Install build packages
RUN apt-get update && apt-get install -y make curl zip git bsdmainutils
# Install transcrypt
RUN git clone https://github.com/elasticdog/transcrypt.git
RUN ln -s /transcrypt/transcrypt /usr/local/bin/transcrypt
# Install awsebcli system dependencies
RUN apt-get update && apt-get install -y build-essential zlib1g-dev libssl-dev libncurses-dev libffi-dev libsqlite3-dev libreadline-dev libbz2-dev
RUN git clone https://github.com/aws/aws-elastic-beanstalk-cli-setup.git
RUN ./aws-elastic-beanstalk-cli-setup/scripts/bundled_installer
RUN echo 'export PATH="/root/.ebcli-virtual-env/executables:$PATH"' >> ~/.profile && . ~/.profile
RUN echo 'export PATH="/root/.pyenv/versions/3.7.2/bin:$PATH"' >> ~/.profile && . ~/.profile
# Install awscli
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
RUN unzip awscliv2.zip
RUN ./aws/install
# Install docker-cli
RUN apt-get update && apt-get install -y \
    apt-transport-https \
    ca-certificates \
    gnupg-agent \
    software-properties-common
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
RUN add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) \
    stable"
RUN apt-get update && apt-get install -y docker-ce-cli
CMD ["/bin/bash"]
