module ApplicationHelper
  DEFAULT_HEADER_COLOR = '#370617'

  def inclination(count, one, two, many)
    return many if (count % 100).between?(11, 14)

    case count % 10
    when 1 then one
    when 2..4 then two
    else
      many
    end
  end

  def header_color
    current_user.present? ? current_user.header_color : DEFAULT_HEADER_COLOR
  end
end
