class Student < ApplicationRecord
  belongs_to :user
  belongs_to :teacher
  has_many :parents
  has_many :grades
end
