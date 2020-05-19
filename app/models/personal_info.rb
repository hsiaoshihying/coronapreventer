class PersonalInfo < ApplicationRecord
  validates :mynumber, presence: true, mynumber: true
  validates :name, presence: true, length: { maximum: 50 }
  validates :address, presence: true, address: true
end
