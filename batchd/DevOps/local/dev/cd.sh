#!/usr/bin/env bash
if ! type dirname > /dev/null 2>&1; then
    echo "Not even a linux or macOS, Windoze? We don't support it. Abort."
    exit 1
fi

. "$(dirname "$0")"/../../common/common.sh

init_with_root_or_sudo "$0"

begin_banner "batchd" "Cont. Deploy"

${SCRIPT_ABS_PATH}/../../../../DevOps/local/dev/prepare.sh
${SCRIPT_ABS_PATH}/../../../../DevOps/local/dev/deploy/prepare.sh

${SCRIPT_ABS_PATH}/prepare.sh
${SCRIPT_ABS_PATH}/deploy/prepare.sh
${SCRIPT_ABS_PATH}/deploy/deploy.sh
${SCRIPT_ABS_PATH}/deploy/finishing.sh
${SCRIPT_ABS_PATH}/finishing.sh

${SCRIPT_ABS_PATH}/../../../../DevOps/local/dev/deploy/finishing.sh
${SCRIPT_ABS_PATH}/../../../../DevOps/local/dev/finishing.sh

done_banner "batchd" "Cont. Deploy"
