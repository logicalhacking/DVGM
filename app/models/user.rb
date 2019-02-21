class User < ApplicationRecord
  validates :role, inclusion: { in: ["admin", "lecturer", "student"], message: "%{value} is not a valid role" }
end
