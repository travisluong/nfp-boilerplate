source vars.sh

ssh-add $SSH_KEY_PATH

# nfp-backend
rsync -av ../nfp-backend $USER@$HOST: --exclude=venv
cp ../nfp-backend/.env.example .env.nfp-backend
sed -i '' "s/DATABASE_URL=.*/DATABASE_URL=postgresql:\/\/$DB_USER:$DB_PASSWORD@localhost\/$DB_NAME/g" .env.nfp-backend
scp .env.nfp-backend $USER@$HOST:~/nfp-backend/.env
ssh $USER@$HOST "
    cd nfp-backend
    python3 -m venv venv
    . venv/bin/activate
    pip install -r requirements.txt
    alembic upgrade head
    pm2 delete nfp-backend
    pm2 start 'gunicorn -w 4 -k uvicorn.workers.UvicornWorker app.main:app' --name nfp-backend
"

# nfp-frontend
rsync -av ../nfp-frontend $USER@$HOST: --exclude=node_modules --exclude=.next
cp ../nfp-frontend/.env.development .env.nfp-frontend
sed -i '' "s/NEXT_PUBLIC_API_URL=.*/NEXT_PUBLIC_API_URL=http:\/\/$HOST\/api/g" .env.nfp-frontend
scp .env.nfp-frontend $USER@$HOST:~/nfp-frontend/.env.local
ssh $USER@$HOST "
    cd nfp-frontend
    npm install
    npm run build
    pm2 delete nfp-frontend
    pm2 start 'npm start' --name nfp-frontend
"

# nginx
cp default.template.conf default.conf
sed -i '' "s/{HOST}/$HOST/g" default.conf
sed -i '' "s/{DOMAIN}/$DOMAIN/g" default.conf
scp default.conf $USER@$HOST:
ssh $USER@$HOST "
    sudo cp default.conf /etc/nginx/conf.d
    sudo service nginx restart
"