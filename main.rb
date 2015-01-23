
require "rubygems"
require "sinatra"
require "active_record"
require "sqlite3"
require "sinatra/base"
require "sinatra/reloader"
require './models/user.rb'
require './models/index.rb'

also_reload 'C:\dev\models\user.rb'
also_reload 'C:\dev\models\index.rb'
also_reload 'C:\dev\views\index.erb'
also_reload 'C:\dev\views\registration.erb'

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
  erb :registration
end

get '/registration_html' do
  '<!DOCTYPE html>
  <!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7"> <![endif]-->
  <!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8"> <![endif]-->
  <!--[if IE 8]>         <html class="no-js lt-ie9"> <![endif]-->
  <!--[if gt IE 8]><!--> <html class="no-js"> <!--<![endif]-->
      <head>
          <meta charset="utf-8">
          <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
          <title> 2 be smart</title>
          <meta name="description" content="Online test engine.">
          <meta name="keywords" content="tests, 2 be smart, 2besmart">
          <meta name="author" content="Stanislav Venkov">
          <meta name="viewport" content="width=device-width">
          <link rel="stylesheet" href="../css/main.css">
          <link rel="stylesheet" href="../css/bootstrap.min.css">
          <style>
              body {
                  padding-top: 60px;
                  padding-bottom: 40px;
              }
          </style>

      <link rel="stylesheet" type="text/css" href="../css/metro-bootstrap.css">
      <link rel="stylesheet" href="../docs/font-awesome.css">
      </head>
      <body>
          <div id="registrationForm">
              <h2>Registration:</h2>
              <form method="POST" action="/save_new_user" id="registrationForm">
                  <div class="labelAndInput">
                      <label>Username:</label>
                      <input type="text" id="name" name="user_name">
                      <span class="errorloc"></span>
                  </div>
                  <div class="labelAndInput">
                      <label>Mail:</label>
                      <input type="text" id="email" name="email">
                      <span class="errorloc"></span>
                  </div>
                  
                  <div class="labelAndInput">
                      <label>Password:</label>
                      <input type="password" id="pass1" name="password">
                      <span class="errorloc"></span>
                  </div>
                  <div class="labelAndInput">
                      <label>Reapeat password:</label>
                      <input type="password" id="pass2" name="password_repeat">
                      <span class="errorloc"></span>
                  </div>
                  <div class="labelAndInput">
                      <label>Gender:</label>
                      <input type="radio" name="sex" value="male">Male
                      <input type="radio" name="sex" value="female">Female
                  </div>
                  
                  <input type="submit" id="registerButton" value="Register">
              </form>
          </div>
      </body>
  </html>
  '
end