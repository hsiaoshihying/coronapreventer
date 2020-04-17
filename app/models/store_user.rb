class StoreUser < ApplicationRecord
  before_save { email.downcase! }

  validates :name, presence: true, length: { maximum: 50 }
  VALID_PHONE_REGEX = /\A\d{10,11}\z/
  validates :phone, presence: true, format: { with: VALID_PHONE_REGEX}
  VALID_ADDRESS_REGEX = /\A(\d{3}-\d{4})+(.+?[都道府県])+(.+?[市区町村])+(.+)/
  validates :address, presence: true, format: { with: VALID_ADDRESS_REGEX}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
            format: { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }
  has_secure_password
end
