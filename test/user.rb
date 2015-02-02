class UserTest < Test::Unit::TestCase
  include Rack::Test::Methods
  require "./require.rb"

  def app
    Sinatra::Application
  end

  def test_register_new_user_with_no_password
    post '/save_new_user' , params= {:email => "test@user.local" , :password => "", :password_repeat => "greatestpasswordEVER"}
    assert last_response.body.include? Constants::SHORT_PASSWORD
  end

  def test_register_new_user_with_short_password
    post '/save_new_user' , params= {:email => "test@user.local" , :password => rand(0..99999).to_s, :password_repeat => "greatestpasswordEVER"}
    assert last_response.body.include? Constants::SHORT_PASSWORD
  end

  def test_register_new_user_right_params
    post '/save_new_user' , params= {:email => "test@user.local" , :password => "greatestpasswordEVER", :password_repeat => "greatestpasswordEVER"}
    assert last_response.ok?
    user = User.where(:email => "test@user.local" ).first
    assert_equal "test@user.local" , user.email
  end

  def test_register_new_user_right_params_but_the_same_email
    post '/save_new_user' , params= {:email => "test@user.local" , :password => "greatestpasswordEVER", :password_repeat => "greatestpasswordEVER"}
    assert last_response.ok?
    assert last_response.body.include? Constants::USERNAME_TAKEN
  end

  def test_user_login_incorrect_password
    post '/login' , params = {:emaillog => "test@user.local"  , :pass  => "greatestpasswordEVER1"}
    assert last_response.ok?
    assert last_response.body.include? Constants::WRONG_PASSWORD
  end

  def test_user_login_correct
    post '/login' , params = {:emaillog => "test@user.local"  , :pass  => "greatestpasswordEVER"}
    get '/tests'
    assert last_response.ok?
    assert last_response.body.include? "test@user.local"
  end
end
# User.where(:email => "test@user.local").first.destroy