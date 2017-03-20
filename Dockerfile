FROM alpine:3.4

ENV CONSUL_TEMPLATE_VERSION=0.18.1

RUN apk update && \
    apk add libnl3 bash haproxy ca-certificates zip && \
    rm -rf /var/cache/apk/*

ADD https://releases.hashicorp.com/consul-template/${CONSUL_TEMPLATE_VERSION}/consul-template_${CONSUL_TEMPLATE_VERSION}_linux_amd64.zip /

RUN unzip /consul-template_${CONSUL_TEMPLATE_VERSION}_linux_amd64.zip \
   && mv /consul-template /usr/local/bin/consul-template \
   && rm -rf /consul-template_${CONSUL_TEMPLATE_VERSION}_linux_amd64.zip

RUN mkdir -p /etc/consul-template/config.d /etc/consul-template/template.d

ADD consul.cfg /etc/consul-template/config.d/consul.cfg
ADD haproxy-consul.cfg /etc/consul-template/config.d/haproxy.cfg
ADD haproxy.tmpl /etc/consul-template/template.d/haproxy.tmpl
ADD launch.sh /launch.sh
ADD haproxy.sh /haproxy.sh

CMD ["/launch.sh"]
