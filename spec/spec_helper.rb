ENV['APP_ROOT'] ||= File.join(File.dirname(__FILE__), 'app')
ENV['APP_ENV'] ||= 'test'

if rsolr_version = ENV['RSOLR_GEM_VERSION']
  STDERR.puts("Forcing RSolr version #{rsolr_version}")
  gem "rsolr", rsolr_version
end

begin
  require 'rspec'
#  require 'rspec/rails'
rescue LoadError => e
  require 'spec'
#  require 'spec/rails'
end
require 'rake'
require 'rubygems'
require 'sqlite3'

#`sunspot-solr start`
require File.join(ENV['APP_ROOT'], 'boot.rb')
#require File.join('sunspot', 'rails', 'solr_logging')

def load_db
#  stdout = $stdout
#  $stdout = StringIO.new # suppress output while building the schema
#  db = YAML.load_file(File.join(ENV['APP_ROOT'], 'db', 'database.yml'))
#  ActiveRecord::Base.establish_connection(db['test'])

  #load File.join(ENV['APP_ROOT'], 'schema.rb')
#  $stdout = stdout
end

def silence_stderr(&block)
  stderr = $stderr
  $stderr = StringIO.new
  yield
  $stderr = stderr
end

rspec =
  begin
    RSpec
  rescue NameError, ArgumentError
    Spec::Runner
  end

rspec.configure do |config|
  config.before(:each) do
    load_db
    Sunspot.remove_all!
    Location.delete_all
    Author.delete_all
    Blog.delete_all
    Post.delete_all
  end
end