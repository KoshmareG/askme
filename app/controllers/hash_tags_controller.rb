class HashTagsController < ApplicationController
  def show
    @questions = HashTag.find_by!(text: params[:text]).questions.order(updated_at: :desc)
  end
end
