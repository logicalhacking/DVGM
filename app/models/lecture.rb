class Lecture < ApplicationRecord
  belongs_to :lecturer
  has_many :grades, dependent: :destroy
  validates :lecturer, presence: true
end
