class UserTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def test_z_user_destroy
  	user = User.where(:email =>"test@user.local" ).first
    User.destroy_all(:id => user.id)
    user.destroy
  	assert !User.where( :email => "test@user.local").first
  end
end