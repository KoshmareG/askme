class HashTagsController < ApplicationController
  def show
    @questions = HashTag.find_by!(text: params[:text]).questions
  end
end
