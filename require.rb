require "rubygems"
require 'active_record'
require "sqlite3"
require "sinatra/base"
require "sinatra/reloader"
require './helpers/constants.rb'
require './models/user.rb'
require './models/test.rb'

also_reload './models/user.rb'
also_reload './models/test.rb'
also_reload './views/index.erb'
also_reload './views/registration.erb'

ActiveRecord::Base.establish_connection(
  :adapter => 'sqlite3',
  :database =>  'to_be_smart.sqlite3.db'
)

set :session_secret, 'to_be_smart'
enable :sessions