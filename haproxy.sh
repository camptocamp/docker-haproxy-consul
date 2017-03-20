#!/bin/sh
/usr/sbin/haproxy -D -p /var/run/haproxy.pid -f /etc/haproxy/haproxy.cfg -sf $(cat /var/run/haproxy.pid) || true
