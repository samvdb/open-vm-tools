# To properly shutdown a CoreOS host we need a base image using systemd
## to make the containers systemctl talk to the host
FROM debian:latest

RUN apt-get update -y &&\
    # install open-vm-tools
    apt-get install -y open-vm-tools &&\
    # remove this script to get a zero returncode since ifup etc. are missing in the base image
    ## this is required for a graceful shutdown
    rm /etc/vmware-tools/scripts/vmware/network &&\
    # Cleanup after install
    apt-get clean &&\
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
ADD scripts /etc/vmware-tools/scripts
RUN chmod -R +x /etc/vmware-tools/scripts/*
ADD tools.conf /etc/vmware-tools/tools.conf
CMD ["/usr/bin/vmtoolsd"]