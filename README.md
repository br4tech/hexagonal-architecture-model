## PRONTO

This app uses **Ruby** version >= 2.6 and **Rails** web framework version 6.

Ruby & Rails & Webpack & React
    
#### Dependencies

Before start the setup, make sure to have the followings libraries previosly installed in our environment: 

- Ruby (>= 2.6)
- PostgreSQL (>= 10)
- Redis
- Yarn

Ubuntu Dependencies:

```sh
sudo apt-get install build-essential gcc libcurl4-openssl-dev libxml2-dev ruby ruby-dev postgresql postgresql-contrib libpq-dev -y
```

#### Setup

```bash
  $ bundle install
  $ bundle exec rake db:create
```

#### Database

Follow this steps to setup your database.  

`$ bundle exec rake db:reset`

Load the schema task to create tables  

`$ bundle exec rake db:schema:load`

Run migrations

`$ bundle exec rake db:migrate`

Check it out the [seed.rb](db/seed.rb) file.  

Get dump in heroku (APP_NAME example: pronto-consultorio-prod):

`$ heroku pg:backups:capture -a APP_NAME`

Make dowload dump:

`$ heroku pg:backups:download -a APP_NAME`

To restore dump

`$ pg_restore --verbose --clean --no-acl --no-owner -h localhost -U postgres -d pronto_development latest.dump`

#### Usage

You need Ruby >= 2.6 in order to run this project. Or you can also use a docker container (instructions below).  

Before starting the project, run the following command to install the node dependencies (ensure yarn is installed)

`$ yarn install`

To start the server, run the following command:

`$ rails server`

The application will be avaliable on the [http://localhost:3000](http://localhost:3000).

### Mapping

Map Heroku Environments

`$ heroku git:remote -a pronto-consultorio-prod`

#### Deployment

`$ git push heroku master`

If there is a migration, just run:

`$  heroku run bundle exec rake db:migrate` 
