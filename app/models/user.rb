class User < ApplicationRecord
  # Include default devise modules. Others available are:
  validates :email, uniqueness: true
  
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :registerable,
         :recoverable, 
         :rememberable, 
         :validatable,
         :confirmable, 
         :trackable
         
  
  has_many :registrations, dependent: :destroy
  has_many :events, through: :registrations
  
  def generate_jwt
    JWT.encode({id: id, exp: 60.days.from_now.to_i}, Rails.application.secrets.secret_key_base)
  end
  
  private
 
  def after_confirmation
    WelcomeMailer.confirmation_notification(self).deliver_now
  end

  
end
