#!/usr/bin/env bash

# add users based on env variable
arr=($USER_LIST)
for i in ${arr[@]}; do # assumes needed users are passed as bash array
  user_array=(${i//:/ })
  echo "${user_array[0]}:dummy:${user_array[1]}:100::/home/${user_array[0]}:/bin/false" | newusers
done

ln -s /conf/smb.conf /usr/local/samba/etc/smb.conf

service samba start && tail -f /usr/local/samba/var/log.smbd