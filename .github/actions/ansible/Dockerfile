FROM ubuntu:latest

RUN apt-get update && apt-get install -y curl && apt-get install -y wget
RUN apt-get install -y git
RUN apt-get install -y inotify-tools
RUN apt-get install -y nano tree vim jq

RUN apt-get update; \
    apt install -y python3-pip; \
    apt install -y sshpass; \
    apt install -y openssh-client; \
    apt-get install -y ipt-transport-https; \
    wget -q https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb;\
    dpkg -i packages-microsoft-prod.deb; \
    apt-get update; \
    add-apt-repository universe; \
    apt-get install -y powershell; \
    pwsh -c "Set-PackageSource -Name PSGallery -Trusted"; \
    pwsh -c "Install-Module AZ -Scope AllUsers";

RUN curl -sL https://aka.ms/InstallAzureCLIDeb | bash ;

RUN pip3 install --upgrade pip; \
    pip3 install "ansible==2.9.12"; \
    pip3 install boto; \
    pip3 install boto3; \
    pip3 install "pywinrm>=0.3.0"; \
    pip3 install ansible[azure] --break-system-packages;; \
    pip3 install ansible-lint --break-system-packages;

COPY ./entrypoint.sh /entrypoint.sh

ENTRYPOINT ["bash", "/entrypoint.sh"]