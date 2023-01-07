module QuestionsHelper
  def hashtag_parser(string)
    string.split(HashTag::TEXT_HASH_TAG_REGEXP).
      map { |text| text.match?(HashTag::HASH_TAG_REGEXP) ? link_to(text, hash_tag_path(text.delete('#').downcase)) : text }.
      join.
      html_safe
  end
end
