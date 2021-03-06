# == Schema Information
#
# Table name: users
#
#  id              :integer         not null, primary key
#  name            :string(255)
#  email           :string(255)
#  created_at      :datetime        not null
#  updated_at      :datetime        not null
#  password_digest :string(255)
#  remember_token  :string(255)
#  admin           :boolean         default(FALSE)
#

class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :password_confirmation # Dette er en getter/setter, som gjør at man kan mass allocate blant annet
    
  # Denne gjør at man kan opprette instansene uten at de har egne kolonner i db - ble erstattet av has_secure_password
  # attr_accessor :password, :password_confirmation 
  has_secure_password

  # before_save { |user| user.email = email.downcase }
  # Kan skrives om til slik som under
  before_save { self.email.downcase! }
  before_save :create_remember_token

  validates :name,
  				presence: true, 
  				length: { maximum: 50 }
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  validates :email, 
  				presence: 	true, 
  				uniqueness: { case_sensitive: false} , 
  				format: { with: VALID_EMAIL_REGEX}

  validates :password,
  				length: { minimum: 6}

	validates :password_confirmation,
  				presence: true

private
  def create_remember_token
    self.remember_token = SecureRandom.urlsafe_base64
  end


end
