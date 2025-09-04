class Employee < ApplicationRecord
  has_many :attendances, dependent: :destroy
end
