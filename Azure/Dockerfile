FROM ubuntu:latest

RUN apt-get update; \
    apt install openssh-client; \
    apt-get install -y wget curl apt-transport-https; \
    curl -sL https://aka.ms/InstallAzureCLIDeb | bash; \
    apt install -y python3-pip;\
    apt install -y sshpass; \

RUN pip3 install --upgrade pip --break-system-packages; \
    pip3 install "ansible==2.9.12" --break-system-packages; \
    pip3 install ansible[azure] --break-system-packages;\
    pip3 install "pywinrm>=0.3.0" --break-system-packages