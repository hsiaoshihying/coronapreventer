class Inquiry < ApplicationRecord
  belongs_to :customer_user
  belongs_to :store_user
  belongs_to :product

  validates :content, presence: true, length: {maximum: 300}
  validates :reply, presence: true, length: {maximum: 300}
end
