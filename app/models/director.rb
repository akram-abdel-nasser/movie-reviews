class Director < ApplicationRecord
  # RELATIONS #
  has_many :movies

  # VALIDATIONS #
  validates_uniqueness_of :name
end
