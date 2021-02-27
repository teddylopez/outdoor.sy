module CustomersHelper

  def titleize_name(title)
    return '' if title.nil?
    return title.titleize
  end

  def format_length(length)
    return sprintf('%.2f', length)
  end

  def style_pagination(page, index)
    if page.to_i == index - 1
      return "active"
    end
  end

  def pagination_limits(model, per_page = 10)
    return (1..(model.all.length / per_page).floor + 1)
  end
end
