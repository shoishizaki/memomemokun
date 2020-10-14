class Memo < ApplicationRecord
  belongs_to :user

  validates :category, presence: true
end
