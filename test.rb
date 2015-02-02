require './main.rb'
require 'test/unit'
require 'rack/test'
require './require.rb'
require './test/user.rb'
# require './test/bookmark.rb'
require './test/destroy.rb'
set :environment, :test
enable :sessions

