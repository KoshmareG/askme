class User < ApplicationRecord
  COLOR_REGEXP_RULE = /\A#[[:xdigit:]]{6}\z/
  DEFAULT_HEADER_COLOR = '#370617'
  NICKNAME_REGEXP_RULE = /\A\w+\z/

  has_secure_password

  before_validation :downcase_nickname
  before_validation :default_header_color

  validates :nickname, presence: true, uniqueness: true,
    length: { maximum: 40 }, format: { with: NICKNAME_REGEXP_RULE }
  validates :email, presence: true, uniqueness: true,
    format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :header_color, presence: true,
    format: { with: COLOR_REGEXP_RULE }

  private

  def downcase_nickname
    nickname&.downcase!
  end

  def default_header_color
    self.header_color ||= DEFAULT_HEADER_COLOR
  end
end
