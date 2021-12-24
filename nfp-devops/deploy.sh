source vars.sh

ssh-add $SSH_KEY_PATH

# nfp-backend
rsync -av ../nfp-backend $USER@$HOST: --exclude=venv
cp ../nfp-backend/alembic.ini .
cp ../nfp-backend/.env .
sed -i '' "s/sqlalchemy.url =.*/sqlalchemy.url = postgresql:\/\/$DB_USER:$DB_PASSWORD@localhost\/$DB_NAME/g" alembic.ini
sed -i '' "s/DATABASE_URL=.*/DATABASE_URL= postgresql:\/\/$DB_USER:$DB_PASSWORD@localhost\/$DB_NAME/g" .env
scp .env alembic.ini $USER@$HOST:~/nfp-backend
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
sed -r "s/{HOST}/$HOST/g" .env.template > .env.local
scp .env.local $USER@$HOST:~/nfp-frontend
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