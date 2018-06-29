#!/bin/bash
set -e

# env vars come from run.sub
echo "workdir: " $workdir
echo "token: " $token
cd $workdir

# setup_anaconda
. /etc/profile.d/anaconda.sh

setup-anaconda
source activate my_env
jupyter lab --NotebookApp.token=$token --no-browser
