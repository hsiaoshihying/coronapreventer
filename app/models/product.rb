class Product < ApplicationRecord
  belongs_to :store_user
  has_many :appointments, dependent: :destroy
  has_many :inquiries, dependent: :destroy
  default_scope -> { order(created_at: :desc) }

  validates :store_user_id, presence: true
  validates :name, presence: true, inclusion: { in: %w(マスク ハンドソープ 殺菌グッズ),
                                                message: "%{value} は無効です" }
  validates :price, presence: true, numericality: { only_integer: true,
                                                    less_than_or_equal_to: 5000,
                                                    greater_than_or_equal_to: 1}
  validates :total_num, presence: true, numericality: { only_integer: true,
                                                        greater_than_or_equal_to: 1}
  validates :order_num, presence: true, numericality: { only_integer: true }
end

