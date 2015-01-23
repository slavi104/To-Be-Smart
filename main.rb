require "rubygems"
require "sinatra"
require "active_record"
require "sqlite3"
require "sinatra/reloader"
require "erb"
require_relative 'user.rb'
require_relative 'index.rb'

also_reload 'C:/Users/Slavi/2besmart/users.rb'
also_reload 'C:/Users/Slavi/2besmart/user.rb'
also_reload 'C:/Users/Slavi/2besmart/index.rb'
also_reload 'C:/Users/Slavi/2besmart/views/index.erb'
also_reload 'C:/Users/Slavi/2besmart/views/registration.erb'

ActiveRecord::Base.establish_connection(
  :adapter => 'sqlite3',
  :database =>  'to_be_smart.sqlite3.db'
)

get '/' do
  Index.show_main_page
end

post '/save_new_user' do
  User.save_new_user(params)
end

get '/users' do
  User.get_all_users
end

get '/registration' do
erb :registration #does not work!!!!!!!!!!!!!!!!!!!!!!!!!

end