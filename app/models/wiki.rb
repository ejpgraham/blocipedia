class Wiki < ApplicationRecord
  belongs_to :user
  has_many :collaborators
  has_many :users, through: :collaborators
  accepts_nested_attributes_for :users


  def public?
    !self.private?
  end
end
