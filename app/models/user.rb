class User < ActiveRecord::Base
  attr_accessor :activation_token
  # before_create :create_activation_digest

  has_secure_password
  has_many :posts

  acts_as_follower
  acts_as_followable

  validates :email,     presence: true, 
                        uniqueness: true
  validates :username,  presence: true, 
                        uniqueness: true,
                        length: { in: 3..15 }

  validates :password,  length: { in: 6..20 }
  validates :password,  confirmation: true
  validates :password,  presence: true, 
                        on: :create, 
                        on: :update, 
                        allow_blank: true
  validates :password_confirmation, 
                        presence: true, 
                        on: :create

  def ratio
    following = self.follow_count.to_f
    followers = self.followers.count.to_f

    if followers == 0
      ratio = "No ratio."
    else
      ratio = (followers / following).round(2)
    end

    return ratio
  end

  private

  # def create_activation_digest
  #   self.activation_token  = User.new_token
  #   self.activation_digest = User.digest(activation_token)
  # end

end
