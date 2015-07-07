class User < ActiveRecord::Base
  has_secure_password
  has_many :posts

  acts_as_follower
  acts_as_followable

  validates :email,     presence: true, 
                        uniqueness: true
  validates :username,  presence: true, 
                        uniqueness: true

  validates :password,  confirmation: true
  validates :password,  presence: true, 
                        on: :create, 
                        on: :update, 
                        allow_blank: true
  validates :password_confirmation, 
                        presence: true, 
                        on: :create
end
