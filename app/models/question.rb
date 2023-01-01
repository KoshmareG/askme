class Question < ApplicationRecord
  belongs_to :user
  belongs_to :author, class_name: 'User', optional: true

  has_many :question_hash_tags, dependent: :destroy
  has_many :hash_tags, through: :question_hash_tags

  validates :body, presence: true, length: { maximum: 280 }

  after_commit :create_hash_tags, on: %i[create update]

  private

  def create_hash_tags
    self.hash_tags =
      "#{body} #{answer}".
        scan(HashTag::HASH_TAG_REGEXP).
        map(&:downcase).
        uniq.
        map { |word| HashTag.create_or_find_by(text: word) }
  end
end
