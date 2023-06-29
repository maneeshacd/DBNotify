desc "Get notification on DB change"
task :listen_db_notify  => :environment do
  Item.listen
end
