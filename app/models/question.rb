class Question < ApplicationRecord
  belongs_to :user
  belongs_to :author, class_name: 'User', optional: true

  has_many :question_hash_tags, dependent: :destroy
  has_many :hash_tags, through: :question_hash_tags

  validates :body, presence: true, length: { maximum: 280 }

  after_commit :create_hash_tags

  private

  def create_hash_tags
    self.question_hash_tags.destroy_all

    (body + ' ' + answer.to_s).scan(HashTag::HASH_TAG_REGEXP).map(&:downcase).uniq.each do |word|
      hash_tag = HashTag.create_or_find_by(text: word)

      QuestionHashTag.create(question_id: self.id, hash_tag_id: hash_tag.id)
    end
  end
end
