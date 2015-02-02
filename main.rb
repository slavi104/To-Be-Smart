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

get '/profile' do
  erb :profile
end

get '/categories' do
  erb :categories
end

post '/login' do
  user = User.login(params[:emaillog], params[:pass])
  erb :index
end

post '/logout' do
  User.logout
  redirect to('./')
end

post '/save_new_user' do
  erb :registration ,:locals => {
                             :errors => User.save_new_user(params)
                           }
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

get '/get_tests' do
  TestUser.get_tests(params['category'])
end

get '/test' do
  erb :test, :locals => {
                        :test => TestUser.get_test(params['id'])
                     } 
end

post '/grade_test' do
  test = TestUser.find_by(:id => params['id'])
  test.grade_json(params)
end

