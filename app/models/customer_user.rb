class CustomerUser < ApplicationRecord
  has_many :appointments, dependent: :destroy
  has_many :inquiries, dependent: :destroy

  before_save { email.downcase! }

  validates :name, presence: true, length: { maximum: 50 }
  VALID_PHONE_REGEX = /\A\d{10,11}\z/
  validates :phone, presence: true, format: { with: VALID_PHONE_REGEX,
                                              message: "は「-」記号を記入しないでください。(記入例：07012345678)"}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
            format: { with: VALID_EMAIL_REGEX ,
                      message: "のフォーマットは正しくないです。(記入例：example@gmail.com)"},
            uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 } , allow_nil: true
  has_secure_password
  validates :mynumber, presence: true, mynumber: true, uniqueness: true
  validates :address, presence: true, address: true


  # 渡された文字列のハッシュ値を返す
  def CustomerUser.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
               BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
end
