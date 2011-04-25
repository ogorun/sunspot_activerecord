require 'rubygems'
require 'sqlite3'
db = SQLite3::Database.new('db/test.sqlite')
puts db.execute('select sqlite_version()')
