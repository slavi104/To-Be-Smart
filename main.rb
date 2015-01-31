require "sinatra"
require './require.rb'
require "sinatra/reloader"
require './helpers/user.rb'

also_reload './models/user.rb'
also_reload './models/test.rb'

PATH_APP = 'C:/dev/'
SESSION = Hash.new

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
  user = User.login(params[:emaillog], params[:pass])
  erb :index ,:locals => {
                       :errors => user.errors,
                       :user_name => user.user_name
  }
end

post '/logout' do
  SESSION['logged'] = false
  SESSION['user_name'] = nil
  SESSION['email'] = nil
  redirect to('./')
end

post '/save_new_user' do
  # User.save_new_user(params)
  registration = User.save_new_user(params)
  if registration
    erb :registration ,:locals => {
                               :errors => registration
                             }
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
  erb :registration ,:locals => {
                               :errors => ''
                             }
end
