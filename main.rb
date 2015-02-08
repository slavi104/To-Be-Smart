require "sinatra"
require './require.rb'
require "sinatra/reloader"
require './helpers/user.rb'
require './helpers/test.rb'
require './helpers/general.rb'

# set :environment, :develop

also_reload './models/user.rb'
also_reload './models/test.rb'
also_reload './models/graded_test.rb'
also_reload './helpers/user.rb'
also_reload './helpers/test.rb'
also_reload './helpers/general.rb'

PATH_APP = 'C:/dev/'