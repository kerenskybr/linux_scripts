# stop and clean a service from systemd
# usage: ./clean_service.sh <servicename>
service=1$; systemctl stop $service && systemctl disable $service && rm /etc/systemd/system/$service &&  systemctl daemon-reload && systemctl reset-failed
