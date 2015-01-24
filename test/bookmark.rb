class UserTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def test_w_add_new_bookmark
    post '/bookmark/add/0' , params= {:title => "MyHomePage" , :url => "http://localhost:8080"} , 'rack.session' => { :user_id => User.where(:user_email => "test@user.local" ).first.user_id }
    get '/bookmarks' , {}, "rack.session" => {:user_id => User.where(:user_email => "test@user.local" ).first.user_id }
    assert (last_response.body.include? "MyHomePage" ) and (last_response.body.include? "http://localhost:8080" ) and (last_response.body.include? "test@user.local")
    #UserLink.where(:user_link_name => "MyHomePage" ).first.destroy
  end

  def test_w_add_new_bookmark_with_wrong_link_url
    post '/bookmark/add/0' , params= {:title => "MyHomePage" , :url => rand(36**rand(0..Constants::LINKS_MIN_LENGHT-1)).to_s(36)} , 'rack.session' => { :user_id => User.where(:user_email => "test@user.local" ).first.user_id }
    assert last_response.body.include? Constants::LINK_MIN_ERROR
  end

  def test_w_add_new_bookmark_with_wrong_link_title
    post '/bookmark/add/0' , params= {:title =>  rand(36**rand(0..Constants::LINK_NAME_MIN-1)).to_s(36) , :url => "http://localhost:8080"} , 'rack.session' => { :user_id => User.where(:user_email => "test@user.local" ).first.user_id }
    assert last_response.body.include? Constants::LINK_NAME_MIN_ERROR
  end

  def test_ww_edit_bookmark
    user_link_id = User.where(:user_email => "test@user.local" ).first.user_links.where(:user_link_name => "MyHomePage").first.user_link_id
    post "/bookmark/edit/#{user_link_id}" , params= {:title => "This is MyHomePage news" , :url => "http://localhost:8080/news"} , 'rack.session' => { :user_id => User.where(:user_email => "test@user.local" ).first.user_id }
    get '/bookmarks' , {}, "rack.session" => {:user_id => User.where(:user_email => "test@user.local" ).first.user_id }
    assert (last_response.body.include? "This is MyHomePage news" ) and (last_response.body.include? "http://localhost:8080/news" ) and (last_response.body.include? "test@user.local")
    #UserLink.where(:user_link_name => "MyHomePage" ).first.destroy
  end

  def test_w_edit_bookmark_with_wrong_link_url
    user_link_id = User.where(:user_email => "test@user.local" ).first.user_links.where(:user_link_name => "MyHomePage").first.user_link_id
    post "/bookmark/edit/#{user_link_id}" , params= {:title => "MyHomePage" , :url => rand(36**rand(0..Constants::LINKS_MIN_LENGHT-1)).to_s(36)} , 'rack.session' => { :user_id => User.where(:user_email => "test@user.local" ).first.user_id }
    assert last_response.body.include? Constants::LINK_MIN_ERROR
  end

  def test_w_edit_bookmark_with_wrong_link_title
    user_link_id = User.where(:user_email => "test@user.local" ).first.user_links.where(:user_link_name => "MyHomePage").first.user_link_id
    post "/bookmark/edit/#{user_link_id}" , params= {:title =>  rand(36**rand(0..Constants::LINK_NAME_MIN-1)).to_s(36) , :url => "http://localhost:8080"} , 'rack.session' => { :user_id => User.where(:user_email => "test@user.local" ).first.user_id }
    assert last_response.body.include? Constants::LINK_NAME_MIN_ERROR
  end
end