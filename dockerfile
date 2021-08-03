FROM ubuntu:latest
ARG USER_ID=1002
ARG GROUP_ID=1002

RUN apt-get update \
 && apt-get install -y --no-install-recommends \
    sudo \
    sshpass \
    openssh-server
 
COPY ssh_config /etc/ssh/ssh_config
COPY sshd_config /etc/ssh/sshd_config
#COPY user.sh /usr/local/bin/user.sh
#RUN chmod +x /usr/local/bin/user.sh
#RUN /usr/local/bin/user.sh

RUN groupadd sftp
COPY sftp.sh /usr/local/bin/sftp.sh
RUN chmod +x /usr/local/bin/sftp.sh
RUN /usr/local/bin/sftp.sh


 
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh
RUN useradd nokapp &&  usermod -aG sudo nokapp
RUN usermod -u ${USER_ID} nokapp
RUN groupmod -g ${GROUP_ID} nokapp
RUN  echo 'nokapp:nokapp' | chpasswd

RUN chown nokapp:nokapp /usr/local/bin/entrypoint.sh && \
    chmod 744 /usr/local/bin/entrypoint.sh 
#USER myuser
USER nokapp
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
EXPOSE 22 
#USER nokapp
CMD tail -f /dev/null

