source vars.sh
ssh-add $SSH_KEY_PATH
scp provision.sh vars.sh $USER@$HOST:
ssh $USER@$HOST ./provision.sh