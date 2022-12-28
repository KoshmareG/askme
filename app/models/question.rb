class Question < ApplicationRecord
  HASH_TAG_REGEXP = /#[[:word:]-]+/

  belongs_to :user
  belongs_to :author, class_name: 'User', optional: true

  has_many :question_hash_tags, dependent: :destroy
  has_many :hash_tags, through: :question_hash_tags

  validates :body, presence: true, length: { maximum: 280 }

  after_commit :create_hash_tags, on: :create
  after_commit :update_hash_tags, on: :update

  private

  def hashtags_from_question_answer
    [body, answer].join(' ').scan(HASH_TAG_REGEXP).map(&:downcase).uniq
  end

  def create_hash_tags
    hashtags_from_question_answer.each do |word|
      hash_tag = HashTag.create_or_find_by(text: word)

      QuestionHashTag.create(question_id: self.id, hash_tag_id: hash_tag.id)
    end
  end

  def update_hash_tags
    self.question_hash_tags.destroy_all

    create_hash_tags
  end
end
