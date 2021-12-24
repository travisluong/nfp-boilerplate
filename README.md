# NFP Boilerplate

* Next.js
* FastAPI
* PostgreSQL

Created By Travis Luong

## Frontend

Install packages.

    $ npm install

Run dev server.

    $ npm run dev

## Backend

Copy `example.env` to `.env`.

Run docker compose.

    $ docker compose up

List running containers.

    $ docker ps

Open terminal into backend container.

    $ docker exec -it nfp-boilerplate-backend-1 bash

Run migrations in backend container.

    $ alembic upgrade head

## Database

Open terminal into postgres container.

    $ docker exec -it nfp-boilerplate-db-1 bash

Open psql in postgres container.

    $ psql -U nfp_boilerplate_user nfp_boilerplate_dev

## Deployment

Copy `vars.example.sh` to `vars.sh`.

Replace the placeholder variables with real variables.

Copy your server's pem file to the `nfp-devops` directory.

Run init to upload scripts to server.

    $ ./init.sh

Provision server.

    $ ./provision.sh

Deploy applications.

    $ ./deploy.sh
