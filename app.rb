require 'sinatra'
require 'sinatra/activerecord'
require 'mysql2'
# this takes a hash of options, almost all of which map directly
# to the familiar database.yml in rails
# See http://api.rubyonrails.org/classes/ActiveRecord/ConnectionAdapters/MysqlAdapter.html
client = Mysql2::Client.new(:host => "localhost", :username => "root")

ActiveRecord::Base.establish_connection(
  :adapter  => "mysql2",
  :host     => "localhost",
  :username => "root",
  :password => "",
  :database => "to_be_smart"
)