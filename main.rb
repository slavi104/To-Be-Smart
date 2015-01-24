require "sinatra"
require './require.rb'
require './helpers/user.rb'

get '/' do
  erb :index
end

post '/save_new_user' do
  User.save_new_user(params)
end

get '/users' do
  User.get_all_users
end

get '/registration' do
  erb :registration
end
