#!/usr/bin/env bash
if ! type dirname > /dev/null 2>&1; then
    echo "Not even a linux or macOS, Windoze? We don't support it. Abort."
    exit 1
fi

. "$(dirname "$0")"/../../../common/common.sh

init_with_root_or_sudo "$0"

begin_banner "batchd" "deploy finishing"

info "Need to do some application initialization, wait 3 seconds to make sure the application containers are ready."
sleep 3
batchd_IMAGE_ID=$(sudo sg docker -c "docker images"|grep -w batchd|awk '{print $3}')
if [ "X${batchd_IMAGE_ID}" != "X" ]; then
    cmdPath=$(sudo sg docker -c "docker image inspect ${batchd_IMAGE_ID}" | grep "/nix/store/" | awk -F"/" '{print "/nix/store/"$4}')
    sudo sed "s:host=db:host=172.17.0.1:g" < /var/batchd/config/batchd.yaml | sudo su -p -c "dd of=/var/batchd/config/batchd.admin.yaml" batchd
    sudo sg docker -c "docker run -it --rm -v /var/batchd/config:/var/batchd/config ${batchd_IMAGE_ID} ${cmdPath}/bin/batchd-admin --config /var/batchd/config/batchd.admin.yaml upgrade-db"
    sudo sg docker -c "docker run -it --rm -v /var/batchd/config:/var/batchd/config ${batchd_IMAGE_ID} ${cmdPath}/bin/batchd-admin --config /var/batchd/config/batchd.admin.yaml create-superuser"
fi

done_banner "batchd" "deploy finishing"
