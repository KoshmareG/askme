class HashTagsController < ApplicationController
  def show
    @questions =
      HashTag.find_by!(text: params[:text]).
        questions.
        includes(:user, :author, :hash_tags).
        order(updated_at: :desc)
  end
end
