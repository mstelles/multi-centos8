FROM centos:8
RUN yum -y update && \
    yum -y install python3 sudo openssh-server nmap-ncat bind-utils httpd-tools

RUN useradd -m ansible
RUN echo "ansible:123" | chpasswd

# ssh server
RUN mkdir /var/run/sshd && \
    ssh-keygen -f /etc/ssh/ssh_host_rsa_key -t rsa -N '' && \
    ssh-keygen -f /etc/ssh/ssh_host_ecdsa_key -t ecdsa -N '' && \
    ssh-keygen -f /etc/ssh/ssh_host_ed25519_key -t ed25519 -N '' && \
    sed -i 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' /etc/pam.d/sshd && \
    echo "export VISIBLE=now" >> /etc/profile && \
    rm /run/nologin
ENV NOTVISIBLE="in users profile"


# general configs
COPY config/id_rsa.pub /home/ansible/.ssh/authorized_keys
RUN echo "set -o vi" >> /etc/profile && \
    echo "ansible	ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers && \
    chown -R ansible.ansible /home/ansible

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
