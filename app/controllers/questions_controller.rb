class QuestionsController < ApplicationController
  before_action :set_question, only: %i[show edit update destroy hide]

  def index
    @questions = Question.all
  end

  def show
  end

  def new
    @question = Question.new
  end

  def create
    question = Question.create(questions_params)

    redirect_to question_path(question)
  end

  def edit
  end

  def update
    @question.update(questions_params)

    redirect_to question_path(@question)
  end

  def destroy
    @question.destroy

    redirect_to questions_path
  end

  def hide
    @question.update(hidden: true)

    redirect_to question_path(@question)
  end

  private

  def questions_params
    params.require(:question).permit(:body, :user_id)
  end

  def set_question
    @question = Question.find(params[:id])
  end
end
