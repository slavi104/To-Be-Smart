require "sinatra"
require './require.rb'
require "sinatra/reloader"
require './helpers/user.rb'

also_reload './models/user.rb'
also_reload './models/test.rb'

get '/' do
  erb :index
end

get '/index' do
  erb :index
end

get '/tests' do
  erb :tests
end

post '/login' do
  'login'
end

post '/save_new_user' do
  # User.save_new_user(params)
  registration = User.save_new_user(params)
  if registration
    registration
  else
    redirect to('./users')
  end
end

get '/users' do
  erb :users, :locals => {
                  :users => User.get_all_users
                }
end

get '/registration' do
  erb :registration
end
