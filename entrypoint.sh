#!/bin/bash
set -e
 
printf "\n\033[0;44m---> Starting the SSH server.\033[0m\n"
echo -e "nokapp\n" | sudo -S sudo service ssh start
 
echo -e "nokapp\n" | sudo -S sudo service ssh status
echo "hello world"



exec "$@"

 
