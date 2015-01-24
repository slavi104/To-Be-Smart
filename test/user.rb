
class UserTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def test_register_new_user_with_no_password
    post '/user/register' , params= {:emailreg => "test@user.local" , :passwordreg => ""}
    assert last_response.body.include? Constants::SHORT_PASSWORD
  end

  def test_register_new_user_with_no_email
    post '/user/register' , params= {:emailreg => "" , :passwordreg => "greatestpasswordEVER"}
     assert last_response.body.include? Constants::EMAIL_TOO_SHORT
  end

  def test_register_new_user_with_short_password
    post '/user/register' , params= {:emailreg => "test@user.local" , :passwordreg => rand(0..99999).to_s}
    assert last_response.body.include? Constants::SHORT_PASSWORD
  end

   def test_register_new_user_with_wrong_email
    post '/user/register' , params= {:emailreg => rand(36**10).to_s(36) , :passwordreg => "greatestpasswordEVER"}
    assert last_response.body.include? Constants::NOTVALID_EMAIL
  end

  def test_register_new_user_right_params
    post '/user/register' , params= {:emailreg => "test@user.local" , :passwordreg => "greatestpasswordEVER"}
    assert last_response.ok?
    user = User.where(:user_email => "test@user.local" ).first
    assert_equal "test@user.local" , user.user_email
  end

  def test_register_new_user_right_params_but_the_same_email
    post '/user/register' , params= {:emailreg => "test@user.local" , :passwordreg => "greatestpasswordEVER"}
    assert last_response.ok?
    assert last_response.body.include? Constants::USERNAME_TAKEN
  end

  def test_user_login_incorrect_password
    post '/user/login' , params = {:email => "test@user.local"  , :password  => "greatestpasswordEVER1"}
    assert last_response.ok?
    assert last_response.body.include? Constants::WRONG_PASSWORD
  end

  def test_user_login_incorrect_email
    post '/user/login' , params = {:email => "test@user.local1"  , :password  => "greatestpasswordEVER"}
    assert last_response.ok?
    assert last_response.body.include? Constants::WRONG_EMAIL
  end

  def test_user_login_correct
    post '/user/login' , params = {:email => "test@user.local"  , :password  => "greatestpasswordEVER"}
    get '/bookmarks'
    assert last_response.ok?
    assert last_response.body.include? "test@user.local"
  end
end







#User.where(:user_email => "test@user.local").first.destroy