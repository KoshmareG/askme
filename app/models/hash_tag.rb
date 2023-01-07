class HashTag < ApplicationRecord
  HASH_TAG_REGEXP = /#[[:word:]-]+/
  TEXT_HASH_TAG_REGEXP = /(#[[:word:]]+)/

  has_many :question_hash_tags
  has_many :questions, through: :question_hash_tags
end
