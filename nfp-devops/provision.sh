source vars.sh

# update
sudo apt-get update

# nginx
sudo apt-get install -y nginx

# nodejs
curl -fsSL https://deb.nodesource.com/setup_16.x | sudo -E bash -
sudo apt-get install -y nodejs

# python
sudo apt-get install -y python3 python3-venv python3-pip

# postgresql
sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
sudo apt-get update
sudo apt-get -y install postgresql

# pm2
sudo npm install -g pm2

# for psycopg2
sudo apt-get install -y libpq-dev build-essential

# postgres user and db
sudo -u postgres createuser $DB_USER
sudo -u postgres createdb $DB_NAME
sudo -u postgres psql -c "ALTER role $DB_USER WITH PASSWORD '$DB_PASSWORD'"