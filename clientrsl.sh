#!/usr/bin/env bash


#SELinux Box Start

semanage port -a -t syslogd_port_t -p tcp 35514
checkmodule -M -m /vagrant/rsyslog_conf/syslog_audit.te -o /root/syslog_audit.mod
semodule_package -m /root/syslog_audit.mod -o /root/syslog_audit.pp
semodule -i /root/syslog_audit.pp
seravice auditd restart

#SELinux Box Stop


cp  /vagrant/rsyslog_conf/05-srvrslauth_log.conf /etc/rsyslog.d/
sed -i.bak 's/access_log  \/var\/log\/nginx\/access.log  main\;/\# access_log  \/var\/log\/nginx\/access.log  main\;/' /etc/nginx/nginx.conf
sed -i '/\# access_log  \/var\/log\/nginx\/access.log  main\;/a   \\t access_log syslog:server\=192.168.10.11:35514,facility\=local6,tag\=nginx_acces,severity\=info combined\;' /e
tc/nginx/nginx.conf
