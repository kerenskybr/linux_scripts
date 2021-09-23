#!/bin/sh
# proxychains wrapper
PROXY_DNS='non-numeric-domain'
PROXY_PORT=1111
PROXY_IP=$(host $PROXY_DNS | tail -n 1 | awk '{n=split($0, a, " "); print a[n];}')
conf=/tmp/pxc4.conf.$$
cat << EOF > $conf
strict_chain
proxy_dns
remote_dns_subnet 224
tcp_read_time_out 15000
tcp_connect_time_out 8000
[ProxyList]
EOF
echo "socks5 $PROXY_IP $PROXY_PORT" >> $conf
trap "rm -f $conf" INT TERM
proxychains4 -f "$conf" "$@"
ec="$?"
rm -f "$conf"
return "$ec"
