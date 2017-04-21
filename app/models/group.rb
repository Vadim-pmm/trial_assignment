class Group < ApplicationRecord
  has_many :users
  has_many :tasks

  validates :name, presence: true

  def can_be_destroyed?
    self.tasks.where('accepted NOT LIKE (?) AND group_id NOT LIKE (?)', true, 1).count.zero?
  end
end
