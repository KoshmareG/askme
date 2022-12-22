class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit destroy]
  before_action :authorise_user, only: %i[edit destroy]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id

      redirect_to root_path, notice: 'Вы зарегистрированы'
    else
      flash.now[:alert] = 'Вы неправильно заполнили поля формы регистрации'

      render :new
    end
  end

  def show
    @questions = @user.questions.order(created_at: :desc)
    @question = Question.new(user: @user)
  end

  def edit
  end

  def update
    @user = User.find_by_nickname(params[:user][:nickname])

    authorise_user

    if @user.update(user_params)
      redirect_to root_path, notice: 'Ваши данные обновлены'
    else
      flash.now[:alert] = 'Вы неправильно заполнили поля формы'

      render :edit
    end
  end

  def destroy
    @user.destroy

    session.delete(:user_id)

    redirect_to root_path, notice: 'Пользователь удален'
  end

  private

  def user_params
    user_params = params.require(:user).
      permit(:name, :nickname, :email, :password, :password_confirmation, :header_color)
  end

  def set_user
    @user = User.find_by_nickname(params[:nickname])
  end

  def authorise_user
    redirect_with_alert unless current_user == @user
  end
end
