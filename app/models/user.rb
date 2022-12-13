class User < ApplicationRecord
  has_secure_password

  before_save :downcase_nickname

  validates :nickname, presence: true, uniqueness: true,
    length: { maximum: 40 }, format: { with: /\A\w+\z/ }
  validates :email, presence: true, uniqueness: true,
    format: { with: URI::MailTo::EMAIL_REGEXP }

  def downcase_nickname
    nickname.downcase!
  end
end
