module ApplicationHelper

  def sortable (column, title = nil)
    title ||= column.titleize
    css_class = column == sort_column ? "current #{sort_direction}" : nil
    direction = column == sort_column && sort_direction == 'asc' ? 'desc' : 'asc'
    link_to title, {:sort => column, :direction => direction, :page => current_page}, {:class => css_class}
  end

  def should_show_pagination(current_page, items)
    (items.length == ITEMS_PER_PAGE) && current_page
  end

  def style_pagination(page, index)
    if page.to_i == index - 1
      return "active"
    end
  end

  def pagination_limits(model, per_page = ITEMS_PER_PAGE)
    return (1...(model.all.length / per_page).floor + 1)
  end

  def last_page(page, total_items)
    items_on_last_page = page.to_i + 2
    return total_items.length % items_on_last_page != 0
  end

end
