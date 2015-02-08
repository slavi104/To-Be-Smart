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