module UsersHelper
  def at_nickname(user)
    "@#{user.nickname}"
  end
end
