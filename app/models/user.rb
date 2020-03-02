class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, presence: true
  # validates :password, length: { minimum: 7 }...会員情報更新の為 hara
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX }
  VALID_BIRTHDAY_REGEX = /\A[0-9]+\z/
  validates :birthday, presence: true, length: { is: 8 }, format: { with: VALID_BIRTHDAY_REGEX }
  VALID_NAME_REGEX = /\A[ぁ-んァ-ン一-龥]/
  validates :lastname, presence: true, format: { with: VALID_NAME_REGEX }
  validates :firstname, presence: true, format: { with: VALID_NAME_REGEX }
  VALID_NAME_KANA_REGEX = /\A[ァ-ヶー－]+\z/
  validates :lastname_kana, presence: true, format: { with: VALID_NAME_KANA_REGEX }
  validates :firstname_kana, presence: true, format: { with: VALID_NAME_KANA_REGEX }

  has_many :cards
  belongs_to :address
end
