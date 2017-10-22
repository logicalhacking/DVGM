class Grade < ApplicationRecord
  belongs_to :lecture
  belongs_to :student
  validates :grade, presence: true
  validates_numericality_of :grade , :less_than_or_equal_to=>100, :greater_than_or_equal_to=>0
  validates :lecture, presence: true
  validates :student, presence: true
end
