class Shortcut < ApplicationRecord
  belongs_to :user

  validates_uniqueness_of :rid
end
