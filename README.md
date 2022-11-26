# NFP Boilerplate

* Next.js
* FastAPI
* PostgreSQL

## Frontend Without Docker

Install packages.

    $ npm install

Run dev server.

    $ npm run dev

## Backend With Docker

Copy `.env.example` to `.env`.

The `.env` should look like this:

    DATABASE_URL=postgresql://nfp_boilerplate_user:password@db/nfp_boilerplate_dev

Run docker compose.

    $ docker compose up

List running containers.

    $ docker ps

Open terminal into backend container.

    $ docker exec -it nfp-boilerplate-backend-1 bash

Run migrations in backend container.

    $ alembic upgrade head

Open terminal into postgres container.

    $ docker exec -it nfp-boilerplate-db-1 bash

Open psql in postgres container.

    $ psql -U nfp_boilerplate_user nfp_boilerplate_dev

## Backend Without Docker

Copy `.env.example` to `.env`.

Change the host in `.env` to `localhost`.

    DATABASE_URL=postgresql://nfp_boilerplate_user:password@localhost/nfp_boilerplate_dev

Set up virtualenv.

    $ python3 -m venv venv
    $ . venv/bin/activate
    $ pip3 install -r requirements.txt

Setup database.

    $ createdb nfp_boilerplate_dev
    $ createuser nfp_boilerplate_user -P

Run migrations

    $ alembic upgrade head

Start server.

    $ uvicorn main:app --reload

## Test

Run tests.

    $ pytest

Run tests with stdout.

    $ pytest -rA

## Deployment

Copy `vars.example.sh` to `vars.sh`.

Copy your server's pem file to the `nfp-devops` directory.

Replace the placeholder variables with real variables.

Run init to provision the server.

    $ ./init.sh

Deploy applications.

    $ ./deploy.sh
