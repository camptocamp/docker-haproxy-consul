#!/bin/bash

/usr/local/bin/consul-template -config /etc/consul-template/config.d \
                               -wait 2s:10s \
                               -consul $CONSUL:8500

