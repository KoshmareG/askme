class User < ApplicationRecord
  COLOR_REGEXP_RULE = /\A#[[:xdigit:]]{6}\z/
  NICKNAME_REGEXP_RULE = /\A\w+\z/

  has_secure_password

  has_many :questions, dependent: :delete_all

  validates :nickname, presence: true, uniqueness: true,
    length: { maximum: 40 }, format: { with: NICKNAME_REGEXP_RULE }
  validates :email, presence: true, uniqueness: true,
    format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :header_color, presence: true,
    format: { with: COLOR_REGEXP_RULE }

  before_validation :downcase_nickname

  include Gravtastic
  gravtastic(secure: true, filetype: :png, size: 100, default: 'retro')

  private

  def downcase_nickname
    nickname&.downcase!
  end
end
