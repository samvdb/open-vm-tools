# To properly shutdown a CoreOS host we need a base image using systemd
## to make the containers systemctl talk to the host
FROM alpine

RUN apk add --no-cache open-vm-tools &&\
    # remove this script to get a zero returncode since ifup etc. are missing in the base image
    ## this is required for a graceful shutdown
    rm /etc/vmware-tools/scripts/vmware/network

CMD ["/usr/bin/vmtoolsd"]


