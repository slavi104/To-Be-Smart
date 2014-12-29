require 'sinatra'
require 'sinatra/activerecord'

ActiveRecord::Base.establish_connection(
  :adapter  => "mysql2",
  :host     => "localhost",
  :username => "root",
  :password => "",
  :database => "to_be_smart"
)