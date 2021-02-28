module Common
  def paginate(page_num, per_page = ITEMS_PER_PAGE)
    return self.offset(page_num.to_i * per_page).limit(per_page)
  end
end
