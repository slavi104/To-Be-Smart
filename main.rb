require "rubygems"
require "sinatra"
require "active_record"
# require 'sinatra/activerecord'
require "sinatra/reloader"


also_reload 'C:/Users/Slavi/2besmart/users.rb'
also_reload 'C:/Users/Slavi/2besmart/index.rb'
also_reload 'C:/Users/Slavi/2besmart/views/index.erb'

get '/users' do
  require_relative 'users.rb'
  User.showUsers
end

get '/index' do
  require_relative 'index.rb'
  Index.showMainPage
end

# get '/' do
#   erb :index
# end

ActiveRecord::Base.establish_connection(
  :adapter  => "mysql",
  :host     => "localhost",
  :username => "root",
  :password => "",
  :database => "to_be_smart"
)

# class User < ActiveRecord::Base
# end

# ActiveRecord::Migration.create_table :users do |t|
#   t.string :name
# end

# class App < Sinatra::Application
# end

# get '/' do
#   p User.all
# end