class QuestionsController < ApplicationController
  before_action :set_question, only: %i[show edit update destroy hide]

  def index
    @questions = Question.all
    @question = Question.new
  end

  def show
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(questions_params)

    if @question.save
      redirect_to question_path(@question), notice: 'Вопрос создан!'
    else
      flash.now[:alert] = 'Вопрос задан неправильно'

      render :new
    end
  end

  def edit
  end

  def update
    if @question.update(questions_params)
      redirect_to question_path(@question), notice: 'Вопрос изменен'
    else
      flash.now[:alert] = 'Вопрос задан неправильно'

      render :edit
    end
  end

  def destroy
    @question.destroy

    redirect_to questions_path, notice: 'Вопрос удален'
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
