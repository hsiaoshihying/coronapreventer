class Appointment < ApplicationRecord
  belongs_to :customer_user
  belongs_to :store_user
  belongs_to :product

  validates :customer_user_id, presence: true
  validates :store_user_id, presence: true
  validates :product_id, presence: true

end
