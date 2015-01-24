class UserTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def test_z_user_destroy
  	user = User.where(:user_email =>"test@user.local" ).first
    UserLink.destroy_all(:user_id => user.user_id)
    user.destroy
  	assert !User.where( :user_email => "test@user.local").first
  end
end