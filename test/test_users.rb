class UserTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def test_grade_test
    test = TestUser.new
    test.content = "Frozen(2013) is?@Documentary$0$Comedy$0$Animation$1$@Who played Forrest Gump in Forrest Gump?@Tom Hanks$1$Johnny Depp$0$Jack Black$0$"
    params = Hash.new
    params["id"] = 4
    params["Frozen(2013)_is?"] = "Animation"
    params["Who_played_Forrest_Gump_in_Forrest_Gump?"] = "Johnny Depp"
    result_json = '{"Frozen(2013)_is?":{"Documentary":"0","Comedy":"0","Animation":"1"},"Who_played_Forrest_Gump_in_Forrest_Gump?":{"Tom_Hanks":"1","Johnny_Depp":"0","Jack_Black":"0"}}'
    session['current_user'] = User.new
    session['current_user'].test_points = 0

    assert test.grade_json(params) == result_json
    assert session['current_user'].test_points == 1
  end

  def test_generate_test
    test = TestUser.new
    test.content = "Frozen(2013) is?@Documentary$0$Comedy$0$Animation$1$@Who played Forrest Gump in Forrest Gump?@Tom Hanks$1$Johnny Depp$0$Jack Black$0$"
    assert test.generate_test.to_s.include? 'Frozen(2013)_is?'
    assert test.generate_test.to_s.include? 'Who_played_Forrest_Gump_in_Forrest_Gump?'
    assert test.generate_test.to_s.include? 'Documentary'
    assert test.generate_test.to_s.include? 'Comedy'
    assert test.generate_test.to_s.include? 'Tom Hanks'
    assert test.generate_test.to_s.include? 'Johnny Depp'
    assert test.generate_test.to_s.scan(/Frozen/).length == 8
    assert test.generate_test.to_s.scan(/Who_played_Forrest_Gump_in_Forrest_Gump/).length == 7
  end
end