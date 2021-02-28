module CustomersHelper
  def titleize_name(title)
    return '' if title.nil?
    return title.titleize
  end

  def format_length(length)
    return sprintf('%.2f', length)
  end
end
