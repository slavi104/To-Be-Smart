class User < ActiveRecord::Base
  
  require_relative '../helpers/constants.rb'
  has_many :tracks
  require 'date'
  require 'time'

  validates_format_of :email, :with => /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/ , :message => Constants::NOTVALID_EMAIL

  validates :email, length: {
    minimum: Constants::EMAIL_MIN_LENGHT,
    maximum: Constants::EMAIL_MAX_LENGHT,
    too_short: Constants::EMAIL_TOO_SHORT,
    too_long: Constants::EMAIL_TOO_LONG
  }

  def self.get_all_users
    @users = User.all().order('test_points DESC')
    index, string, points = 0, '', 0
    @users.each do |user|
      index += 1 unless points == user.test_points
      string << "<tr>
                    <th>#{user.user_name}</th>
                    <th>#{user.test_points}</th>
                    <th>#{index}</th>
                    <th>#{user.created_on}</th>
                </tr>"
      points = user.test_points
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
      new_user.created_on = Date.today.to_s
      # puts Date.today.to_s
      new_user.save
    elsif password.size < Constants::PASSWORD_MIN_LENGHT
      Constants::SHORT_PASSWORD
    elsif existing_user.size > 0
      Constants::USERNAME_TAKEN
    elsif params[:password] != params[:password_repeat]
      Constants::NOTEQUAL_PASSWORDS
    end
  end

  def self.login(mail="user",password="pass", session)
    pass = Digest::MD5.hexdigest password.reverse
    current_user = User.find_by(email: mail , password: pass)

    if current_user
      session['id'] = current_user.id
      session['logged'] = true
      session['user_name'] = current_user.user_name
      session['email'] = current_user.email
      session['current_user'] = current_user
      session['errors'] = ''
    else
      current_user = User.new
      if User.find_by(email: mail)
        session['errors'] = Constants::WRONG_PASSWORD
      elsif User.find_by(password: pass)
        session['errors'] = Constants::WRONG_EMAIL
      end
    end

    current_user.errors[:email] << Constants::WRONG_EMAIL unless current_user and User.find_by(:email => mail )
    current_user.errors[:password] << Constants::WRONG_PASSWORD unless current_user and User.find_by(:password => pass  )
    current_user
  end

  def self.logout
    session['logged'] = false
    session['user_name'] = nil
    session['email'] = nil
    session['current_user'] = User.new
  end

end