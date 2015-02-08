class UserTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def test_add_graded
    session = Hash.new
    session['current_user'] = User.where(:id => 1).first
    session['id'] = 1
    assert GradedTest.add_graded(1, 1, session)
    last_graded = GradedTest.all().last()
    assert last_graded.test_id == 1
    assert last_graded.points == 1
    assert last_graded.user_id == 1
  end
end