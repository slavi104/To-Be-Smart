class User < ActiveRecord::Base
  require_relative '../helpers/constants.rb'
  has_many :tracks

  def self.get_all_users
    @users = User.all()
    string = ''
    @users.each do |user|  
      string << user.user_name << '<br>'
    end
    string
  end

  def self.save_new_user(params)
    password = params[:password]
    existing_user = User.where(:email => params[:email])

    if password == params[:password_repeat] && password.size >= Constants::PASSWORD_MIN_LENGHT && existing_user.size == 0
      pass = Digest::MD5.hexdigest password.reverse
      new_user = User.new
      new_user.user_name = params[:user_name]
      new_user.password = pass
      new_user.email = params[:email]
      new_user.sex = params[:sex]
      new_user.is_active = 1
      new_user.test_points = 0
      new_user.save
      false
    elsif params[:password] != params[:password_repeat]
      Constants::NOTEQUAL_PASSWORDS
    elsif password.size < Constants::PASSWORD_MIN_LENGHT
      Constants::SHORT_PASSWORD
    elsif existing_user.size > 0
      Constants::USERNAME_TAKEN
    end
  end

  # validates_format_of :email, :with => /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/ , :message => Constants::NOTVALID_EMAIL

  # validates :email, length: {
  #   minimum: Constants::EMAIL_MIN_LENGHT,
  #   maximum: Constants::EMAIL_MAX_LENGHT,
  #   too_short: Constants::EMAIL_TOO_SHORT,
  #   too_long: Constants::EMAIL_TOO_LONG
  # }



  # def self.register(mail="user",password="pass")
  #   existing_user = User.where(:email => mail)
  #   pass = Digest::MD5.hexdigest password.reverse
  #   user = User.new
  #   user = User.create(:email => mail , :password => pass ) if password.size > Constants::PASSWORD_MIN_LENGHT and existing_user.size == 0
  #   user.errors[:password] << Constants::SHORT_PASSWORD if password.size < Constants::PASSWORD_MIN_LENGHT
  #   user.errors[:email] << Constants::USERNAME_TAKEN if existing_user.size > 0
  #   user
  # end

  # def self.generate_password(password="pass")
  #   Digest::MD5.hexdigest password.reverse
  # end

  # def self.login(mail="user",password="pass")
  #   pass = Digest::MD5.hexdigest password.reverse
  #   current_user = User.find_by(email: mail , :password => pass )
  #   current_user = User.new unless current_user
  #   current_user.errors[:email] << Constants::WRONG_EMAIL unless current_user and User.find_by(:email => mail )
  #   current_user.errors[:password] << Constants::WRONG_PASSWORD unless current_user and User.find_by(:password => pass  )
  #   current_user
  # end

end