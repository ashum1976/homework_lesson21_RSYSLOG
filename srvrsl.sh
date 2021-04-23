#!/usr/bin/env bash
sed -i.bak 's/#module(load="imudp")/module(load="imudp"); s/#input(type="imudp" port="514")/input(type="imudp" port="35514"); s/#module(load="imtcp")/module(load="imtcp"; ); s/#input(type="imtcp" port="514")/input(type="imtcp" port="35514")' /etc/rsyslog.conf
