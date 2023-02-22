class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable
  # Validations
  # VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze

  validates :username, presence: true, uniqueness: true, length: { maximum: 16 }
  validates :email, presence: true, uniqueness: true
  # validates :email, format: { with: VALID_EMAIL_REGEX }, allow_blank: true
  # validates :birth_date, comparison: { less_than: 16.years.ago,
  #                                      message: "should be older than 16 years ago" },
  #                        allow_blank: true

  # Association
  has_many :critics, dependent: :destroy
#   has_secure_password
  enum role: { admin: 0,
    basic: 1 }

  # metodo de clase
  def self.from_omniauth(auth_hash)
    where(provider: auth_hash.provider, uid: auth_hash.uid).first_or_create do |user|
      user.provider = auth_hash.provider
      user.uid = auth_hash.uid
      user.username = auth_hash.info.name
      user.email = auth_hash.info.email
      user.password = Devise.friendly_token[0,20]
      # binding.pry
    end
  end

end
