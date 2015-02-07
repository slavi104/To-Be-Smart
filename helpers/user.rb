post '/login' do
  user = User.login(params[:emaillog], params[:pass], session)
  erb :index
end

post '/logout' do
  User.logout
  redirect to('./index')
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