FROM alpine
MAINTAINER David Personette <dperson@gmail.com>

# Install openvpn
RUN apk --no-cache --no-progress upgrade && \
    apk --no-cache --no-progress add bash curl ip6tables iptables openvpn \
                shadow tini && \
    addgroup -S vpn && \
    rm -rf /tmp/*

COPY openvpn.sh /usr/bin/
#COPY vpn/ca.crt /vpn/vpn-ca.crt

HEALTHCHECK --interval=60s --timeout=15s --start-period=120s \
             CMD curl -L 'https://api.ipify.org'

VOLUME ["/vpn"]

ENTRYPOINT ["/sbin/tini", "--", "/usr/bin/openvpn.sh"]

# docker run --name vpn --rm --cap-add=NET_ADMIN --device /dev/net/tun --dns 209.222.18.222 --dns 209.222.18.218 vpn -f "" -d -v 'denmark.privateinternetaccess.com;user;pass;1194'