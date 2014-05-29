require 'yaml'
require 'active_record'

ENV["ENV"] ||= 'development'

desc "Migrate database"
task :migrate => :environment do
  ActiveRecord::Migrator.migrate 'db/migrate', ENV["VERSION"] ? ENV["VERSION"].to_i : nil
end

task :environment do
  config = YAML.load_file 'config.yml'
  ActiveRecord::Base.establish_connection config['database'][ENV['ENV']]
  ActiveRecord::Base.logger = Logger.new 'db/database.log'
end
