# README

This README would normally document whatever steps are necessary to get the
application up and running.

## Database creation and configuration
In order to set up the database run the following commands:
rake db:drop
rake db:create
rake db:migrate

In order to run test using the seeded database, use the following commands after migrations:
rake db:setup
rake db:seed RAILS_ENV=test --trace

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
