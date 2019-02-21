class Grade < ApplicationRecord
  has_one_attached :submission
  belongs_to :lecture
  belongs_to :student
  validates_numericality_of :grade , :less_than_or_equal_to=>100, :greater_than_or_equal_to=>0, :allow_nil => true
  validates :lecture, presence: true
  validates :student, presence: true
  validate :submission_size_validation

  def submission_size_validation
    if submission.attached?
      errors[:grade] << "attachment must be less than 500kB" if submission.blob.byte_size > 500.kilobytes
      errors[:grade] << "attachment must be a pdf" if submission.filename.extension != "pdf"
    end
  end 
end
