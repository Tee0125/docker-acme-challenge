from python:3.6-alpine

RUN apk update && \
    apk add bash openssl curl && \
    rm -rf /var/cache/apk/*

RUN pip install dnspython==1.15.0 \
                future==0.15.2    \
                requests==2.9.1   \
                six==1.10.0       \
                tld==0.7.6

ADD dehydrated /opt/dehydrated
ADD hook /opt/hook
 
ADD config domains.txt /etc/dehydrated/
ADD entrypoint.sh /entrypoint.sh

RUN chmod 755 /entrypoint.sh && \
    chmod 755 /opt/hook/hook.py && \
    chmod 755 /opt/dehydrated/dehydrated && \
    mkdir -p /var/lib/dehydrated/certs

CMD ["/entrypoint.sh"]
