require 'rubygems'
require 'active_record'
require 'sunspot'
require 'sunspot_activerecord'

ENV['APP_PATH'] ||= File.dirname(__FILE__)
env = ENV['APP_ENV'] || 'development'


db = YAML.load_file(File.join(ENV['APP_ROOT'], 'db', 'database.yml'))
db[env][:database] = ENV['APP_PATH'] + '/' + db[env][:database]
ActiveRecord::Base.establish_connection(db[env])


$LOAD_PATH.unshift("#{ENV['APP_ROOT']}/models")
Dir.glob("#{ENV['APP_ROOT']}/models/*.rb") { |model| require File.basename(model, '.*') }
