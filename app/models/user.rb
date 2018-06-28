class User < ApplicationRecord
  acts_as_authentic
  validates :role, inclusion: { in: ["admin", "lecturer", "student"], message: "%{value} is not a valid role" }
end
