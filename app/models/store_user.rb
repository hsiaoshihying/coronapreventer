class StoreUser < ApplicationRecord
  has_many :products, dependent: :destroy
  has_many :appointments
  has_many :customer_users, through: :appointments
  has_many :inquiries, dependent: :destroy

  attr_accessor :remember_token, :activation_token, :reset_token
  before_save { email.downcase! }

  validates :name, presence: true, length: { maximum: 50 }
  VALID_PHONE_REGEX = /\A\d{10,11}\z/
  validates :phone, presence: true, format: { with: VALID_PHONE_REGEX,
             message: "は「-」記号を記入しないでください。(記入例：07012345678)"}
  VALID_ADDRESS_REGEX = /\A(\d{3}-\d{4})+(.+?[都道府県])+(.+?[市区町村])+(.+)/
  validates :address, presence: true, address: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
            format: { with: VALID_EMAIL_REGEX,
                      message: "のフォーマットは正しくないです。(記入例：example@gmail.com)"},
            uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
  has_secure_password

  # 渡された文字列のハッシュ値を返す
  def StoreUser.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
               BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def feed
    Product.where("store_user_id = ?", id)
  end

end
