FROM centos:latest

RUN yum install -y openssh-server

RUN mkdir /var/run/sshd
RUN echo 'root:DanielSmithRocks' | chpasswd
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

EXPOSE 22
RUN /usr/bin/ssh-keygen -A

CMD ["/usr/sbin/sshd", "-D"]
