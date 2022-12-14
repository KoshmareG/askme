class User < ApplicationRecord
  DEFAULT_HEADER_COLOR = '#370617'

  has_secure_password

  before_validation :downcase_nickname
  before_save :default_header_color

  validates :nickname, presence: true, uniqueness: true,
    length: { maximum: 40 }, format: { with: /\A\w+\z/ }
  validates :email, presence: true, uniqueness: true,
    format: { with: URI::MailTo::EMAIL_REGEXP }

  private

  def downcase_nickname
    nickname&.downcase!
  end

  def default_header_color
    self.header_color ||= DEFAULT_HEADER_COLOR
  end
end
