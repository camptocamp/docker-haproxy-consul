FROM debian:stretch

MAINTAINER Mathieu Bornoz <mathieu.bornoz@camptocamp.com>

ENV CONSUL_TEMPLATE_VERSION=0.11.1
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
  && apt-get install -y curl unzip haproxy procps \
  && rm -rf /var/lib/apt/lists/*

ADD https://releases.hashicorp.com/consul-template/${CONSUL_TEMPLATE_VERSION}/consul-template_${CONSUL_TEMPLATE_VERSION}_linux_amd64.zip /

RUN unzip /consul-template_${CONSUL_TEMPLATE_VERSION}_linux_amd64.zip \
   && mv /consul-template /usr/local/bin/consul-template \
   && rm -rf /consul-template_${CONSUL_TEMPLATE_VERSION}_linux_amd64.zip

RUN mkdir -p /etc/consul-template/config.d /etc/consul-template/template.d

ADD consul.cfg /etc/consul-template/config.d/consul.cfg
ADD haproxy-consul.cfg /etc/consul-template/config.d/haproxy.cfg
ADD haproxy.tmpl /etc/consul-template/template.d/haproxy.tmpl
ADD launch.sh /launch.sh

CMD ["/launch.sh"]
