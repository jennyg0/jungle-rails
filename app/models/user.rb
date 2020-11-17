class User < ActiveRecord::Base
  has_secure_password

  validates :name, presence: true
  validates :email, uniqueness: true, presence: true
  validates :password, length: { minimum: 8 }, presence: true
  validates :password_confirmation, presence: true

  def self.authenticate_with_credentials email, password
    fixed_email = email.downcase.strip
    @user = User.find_by_email(fixed_email)
    if @user && @user.authenticate(password)
      @user
    else
      nil
    end
  end

  
end
