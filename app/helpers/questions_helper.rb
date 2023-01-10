module QuestionsHelper
  def hashtag_parser(string)
    string.gsub(HashTag::HASH_TAG_REGEXP) { |text| link_to(text, hash_tag_path(text.delete('#').downcase)) }
  end
end
