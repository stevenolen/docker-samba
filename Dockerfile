FROM debian:jessie
MAINTAINER Steve Nolen <technolengy@gmail.com>

ENV SAMBA_VERSION 4.3.4

WORKDIR /root
RUN set -x \
  && export DEBIAN_FRONTEND=noninteractive \
  && apt-get update \
  && apt-get install -y wget build-essential pkg-config libacl1 acl libacl1-dev libblkid-dev \
  libblkid1 attr libattr1 libattr1-dev libgnutls28-dev libreadline-dev python-dev python-dnspython \
  gdb libpopt-dev libldap2-dev dnsutils libbsd-dev krb5-user docbook-xsl libcups2-dev libncurses-dev \
  libpam0g-dev libdm0-dev libfam0 fam libfam-dev xsltproc libnss3-dev docbook-xsl-doc-html docbook-xsl-ns \
  && wget https://download.samba.org/pub/samba/samba-$SAMBA_VERSION.tar.gz \
  && tar zxf samba-$SAMBA_VERSION.tar.gz \
  && cd samba-$SAMBA_VERSION \
  && ./configure && make && make install \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD smbd-init.sh /etc/init.d/samba
RUN chmod +x /etc/init.d/samba
ADD run.sh /run.sh
RUN chmod +x /run.sh

EXPOSE 137
EXPOSE 138
EXPOSE 139
EXPOSE 445

RUN mkdir /shares
RUN mkdir /conf
RUN mkdir /private && rm -rf /usr/local/samba/private && ln -s /private /usr/local/samba/
VOLUME ['/private', '/shares', '/conf']

CMD ["/run.sh"]