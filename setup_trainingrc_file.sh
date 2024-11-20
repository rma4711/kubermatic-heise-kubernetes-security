#!/bin/bash

TRAINING_RC_FILE=/root/.trainingrc

set -euxo pipefail

# cleanup .trainingrc file
rm -f $TRAINING_RC_FILE
touch $TRAINING_RC_FILE

# add .trainingrc file into .bashrc
grep -qxF "source $TRAINING_RC_FILE" ~/.bashrc || echo "source $TRAINING_RC_FILE" >> ~/.bashrc

# add kubernetes bash completion
echo "source <(kubectl completion bash)" >> $TRAINING_RC_FILE

# set useful env vars
echo "export IP=$(hostname -i)" >> $TRAINING_RC_FILE
echo "export API_SERVER=https://$(hostname -i):6443" >> $TRAINING_RC_FILE

# make the cli prompt nice
echo 'PS1="\[\033[0;32m\]\u@\H \[\033[0;34m\]\w >\e[0m "' >> $TRAINING_RC_FILE
