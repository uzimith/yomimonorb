require 'factory_girl'
require 'active_record'
require 'debugger'
require 'awesome_print'
require 'database_cleaner'
require 'yaml'

ENV["ENV"] ||= 'test'

$:.unshift File.join(File.dirname(__FILE__), '..', 'lib')
Dir[File.join(File.dirname(__FILE__), "..", "lib", "**/*.rb")].each do |f|
  require f
end
FactoryGirl.definition_file_paths = %w{./factories ./test/factories ./spec/factories}
FactoryGirl.find_definitions
 
RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
  config.before :all do
    config = YAML.load_file 'config.yml'
    ActiveRecord::Base.establish_connection config['database'][ENV['ENV']]
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end
  config.before :each do
    DatabaseCleaner.start
  end

  config.after :each do
    DatabaseCleaner.clean
  end

  config.after :each do
    ActiveRecord::Base.connection.close
  end
end
