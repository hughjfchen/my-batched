#!/usr/bin/env bash
if ! type dirname > /dev/null 2>&1; then
    echo "Not even a linux or macOS, Windoze? We don't support it. Abort."
    exit 1
fi

. "$(dirname "$0")"/../../../common/common.sh

init_with_root_or_sudo "$0"

begin_banner "batchd" "build prepare"

#set +u to workaround the nix script temperlately.
set +u
. $HOME/.nix-profile/etc/profile.d/nix.sh
set -u

# generate nix file for the project and sub modules
ls ${SCRIPT_ABS_PATH}/../../../../batchd-core/*.cabal > /dev/null 2>&1 || ls ${SCRIPT_ABS_PATH}/../../../../batchd-core/package.yaml > /dev/null 2>&1 && cabal2nix ${SCRIPT_ABS_PATH}/../../../../batchd-core > ${SCRIPT_ABS_PATH}/nix/batchd-core.nix
ls ${SCRIPT_ABS_PATH}/../../../../*.cabal > /dev/null 2>&1 || ls ${SCRIPT_ABS_PATH}/../../../../package.yaml > /dev/null 2>&1 && cabal2nix ${SCRIPT_ABS_PATH}/../../../.. > ${SCRIPT_ABS_PATH}/nix/batchd.nix

done_banner "batchd" "build prepare"
