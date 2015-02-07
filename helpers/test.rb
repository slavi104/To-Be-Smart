get '/tests' do
  erb :tests
end
get '/get_tests' do
  TestUser.get_tests(params['category'], session)
end

get '/test' do
  erb :test, :locals => {
                        :test => TestUser.get_test(params['id'])
                     } 
end

post '/grade_test' do
  test = TestUser.find_by(:id => params['id'])
  test.grade_json(params, session)
end