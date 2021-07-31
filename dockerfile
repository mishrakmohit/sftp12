FROM debian:9.5
 
ARG SSH_MASTER_USER
ARG SSH_MASTER_PASS
 
RUN apt-get update \
 && apt-get install -y --no-install-recommends \
    nano \
    sudo \
    sshpass \
    openssh-server
 
COPY ssh_config /etc/ssh/ssh_config
COPY sshd_config /etc/ssh/sshd_config
COPY user.sh /usr/local/bin/user.sh
RUN chmod +x /usr/local/bin/user.sh
RUN /usr/local/bin/user.sh


COPY sftp.sh /usr/local/bin/sftp.sh
RUN chmod +x /usr/local/bin/sftp.sh
RUN /usr/local/bin/sftp.sh


 
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh
RUN useradd myuser &&  usermod -aG sudo myuser
RUN  echo 'myuser:myuser' | chpasswd

RUN chown myuser:myuser /usr/local/bin/entrypoint.sh && \
    chmod 744 /usr/local/bin/entrypoint.sh 
#USER myuser

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
EXPOSE 22 
USER myuser
CMD tail -f /dev/null

