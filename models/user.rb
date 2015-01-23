class User < ActiveRecord::Base

  has_many :tracks

  def self.get_all_users
    @users = User.all()
    string = ''
    @users.each do |user|  
      string << user.user_name << '---' << user.password << '<br>'
    end
    string
  end

  def self.index
    erb :index
  end

  def self.save_new_user(params)
    new_user = User.new
    new_user.user_name = params[:user_name]
    new_user.password = params[:password]
    new_user.email = params[:email]
    new_user.sex = params[:sex]
    new_user.is_active = 1
    new_user.test_points = 0
    new_user.save.to_s
  end

end