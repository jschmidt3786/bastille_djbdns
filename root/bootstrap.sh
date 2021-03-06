#!/usr/bin/env bash
set -o errexit
set -o nounset
set -o pipefail

[ -f /var/tmp/djbdns_fin ] && exit 0

for U in dnslog tinydns axfrdns dnscache ; do
  pw useradd -n "$U" -c "$U daemon" -m -s /usr/sbin/nologin
done

mkdir -p /var/service /var/log/dnslog/tinydns /var/log/dnslog/axfrdns
chmod -R 770 /var/log/dnslog
chown -R dnslog:dnslog /var/log/dnslog
echo "svscan_servicedir=/var/service" >> /etc/rc.conf
ifconfig bastille0 |grep "inet " |awk '{print $2}' > /tmp/IP

tinydns-conf tinydns dnslog /var/tinydns "$(cat /tmp/IP)"
sed -i .bak s/^exec/#exec/ /var/tinydns/log/run
echo "exec setuidgid dnslog multilog t s16777215 n100 /var/log/dnslog/tinydns" >> /var/tinydns/log/run
rm -rf /var/tinydns/log/main /var/tinydns/log/run.bak
ln -s /var/tinydns /var/service

axfrdns-conf axfrdns dnslog /var/axfrdns /var/tinydns "$(cat /tmp/IP)"
sed -i .bak s/^exec/#exec/ /var/axfrdns/log/run
echo "exec setuidgid dnslog multilog t s16777215 n100 /var/log/dnslog/axfrdns" >> /var/axfrdns/log/run
grep -v ^# /var/axfrdns/tcp
cd /var/axfrdns && make
rm -rf /var/axfrdns/log/main /var/axfrdns/log/run.bak
ln -s /var/axfrdns /var/service

touch /var/tmp/djbdns_fin
