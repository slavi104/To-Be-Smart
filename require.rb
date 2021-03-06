require "rubygems"
require 'active_record'
require "sqlite3"
require "sinatra/base"
require './helpers/constants.rb'
require './models/user.rb'
require './models/test.rb'
require './models/graded_test.rb'
require 'chrome_logger'
use ChromeLogger

ActiveRecord::Base.establish_connection(
  :adapter => 'sqlite3',
  :database =>  'to_be_smart.sqlite3.db',
  :pool => 30000,
  :timeout => 10000
)

set :session_secret, 'to_be_smart'
enable :sessions