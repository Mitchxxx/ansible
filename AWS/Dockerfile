FROM ubuntu:latest

RUN apt-get update; \
    apt install -y openssh-client; \
    apt install -y python3-pip; \
    apt install -y sshpass; \

RUN pip3 install --upgrade pip --break-system-packages; \
    pip3 install "ansible==2.9.12" --break-system-packages; \
    pip3 install boto --break-system-packages; \
    pip3 install boto3 --break-system-packages; \
    pip3 install "pywinrm>=0.3.0" --break-system-packages; \
    pip3 install ansible-lint --break-system-packages;