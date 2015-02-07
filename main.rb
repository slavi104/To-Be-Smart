require "sinatra"
require './require.rb'
require "sinatra/reloader"
require './helpers/user.rb'
require './helpers/test.rb'

also_reload './models/user.rb'
also_reload './models/test.rb'
also_reload './models/graded_test.rb'
also_reload './helpers/user.rb'
also_reload './helpers/test.rb'

PATH_APP = 'C:/dev/'

Object::IS_TEST = false

get '/' do
  erb :index
end

get '/index' do
  erb :index 
end

get '/profile' do
  graded_tests = GradedTest::get_graded(session)
  erb :profile, :locals => {
                              :tests => graded_tests,
                              :procent_tests => GradedTest::procent_tests(session),
                              :success_tests => GradedTest::success_tests(session)
                          }
end

get '/categories' do
  erb :categories
end

get '/registration' do
  erb :registration ,:locals => {
                               :errors => ''
                             }
end

get '/*' do
  redirect to('./index')
end