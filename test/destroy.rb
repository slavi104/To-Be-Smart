class UserTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def test_user_destroy
  	user = User.where(:email =>"test@user.local" ).first
    User.destroy_all(:id => user.id)
    user.destroy
  	assert !User.where( :email => "test@user.local").first
  end

  def test_grade_test_destroy
    graded_tests = GradedTest.where(:user_id => 1).first
    GradedTest.destroy_all(:id => graded_tests.id)
    graded_tests.destroy
    assert !GradedTest.where(:user_id => 1).first
  end
end