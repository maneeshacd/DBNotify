### Requirements
* Rails 7
* Postgresql 14.8
* Redis
* Sidekiq
* Rspec

### Steps
1. bundle install
2. setup database.yml with appropriate creds.
3. rails db:create db:migrate
4. Run Sidekiq using the command `sidekiq`
5. run the rake task `rake listen_db_notify`. It will listen to the Postgres DB notify, and triggers whenever a DB change happens
6. Make a DB change, the batch will get updated and you will be able to see "Batch updated" message in sidekiq
