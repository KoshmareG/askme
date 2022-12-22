class QuestionsController < ApplicationController
  before_action :ensure_current_user, only: %i[edit update destroy hide]
  before_action :set_question_for_current_user, only: %i[edit update destroy hide]

  def index
    @questions = Question.order(created_at: :desc).last(10)
    @users = User.order(created_at: :desc).last(10)
  end

  def show
    @question = Question.find(params[:id])
  end

  def new
    @user = User.find_by!(nickname: params[:nickname])
    @question = Question.new(user: @user)
  end

  def create
    question_params = params.require(:question).permit(:body, :user_id)

    @question = Question.new(question_params)
    @question.author = current_user

    if @question.save
      redirect_to user_path(@question.user.nickname), notice: 'Вопрос создан!'
    else
      flash.now[:alert] = 'Вопрос задан неправильно'

      render :new
    end
  end

  def edit
  end

  def update
    question_params = params.require(:question).permit(:body, :answer)

    if @question.update(question_params)
      redirect_to user_path(@question.user.nickname), notice: 'Вопрос изменен'
    else
      flash.now[:alert] = 'Вопрос задан неправильно'

      render :edit
    end
  end

  def destroy
    @user = @question.user
    @question.destroy

    redirect_to user_path(@user.nickname), notice: 'Вопрос удален'
  end

  def hide
    @question.update(hidden: true)

    redirect_to question_path(@question)
  end

  private

  def ensure_current_user
    redirect_with_alert unless current_user.present?
  end

  def set_question_for_current_user
    @question = current_user.questions.find(params[:id])
  end
end
