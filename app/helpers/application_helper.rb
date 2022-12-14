module ApplicationHelper
  def inclination(count, one, two, many)
    return many if (count % 100).between?(11, 14)

    case count % 10
    when 1 then one
    when 2..4 then two
    else
      many
    end
  end

  def header_color(user)
    user&.header_color.present? ? user.header_color : User::DEFAULT_HEADER_COLOR
  end
end
