class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  after_initialize :give_user_standard_role_only

  has_many :wikis

  def give_user_standard_role_only
    self.standard = true
  end
end
