class PaginationListLinkRenderer < WillPaginate::ActionView::LinkRenderer

  protected

    def page_number(page)
      unless page == current_page
        tag(:li, link(page, page, :rel => rel_value(page)))
      else
        tag(:li, page, :class => "current")
      end
    end

    def previous_or_next_page(page, text, classname)
      if page
        tag(:li, link(text, page), :class => classname)
      else
        tag(:li, text, :class => classname + ' disabled')
      end
    end

    def html_container(html)
      tag(:ul, html, container_attributes)
    end


 def container_attributes
    super.except(:first_label, :last_label, :summary_label)
  end

  protected

    def pagination
      items = []
      items << :first_page if current_page > 2
      items << :previous_page if current_page > 1
      items << :summary
      items << :next_page if current_page < total_pages
      items << :last_page if current_page < total_pages - 1
      items
    end

    def first_page
      previous_or_next_page(1, @options[:first_label], "first_page")
    end

    def last_page
      previous_or_next_page(total_pages, @options[:last_label], "last_page")
    end

    def summary
      tag(:span, @options[:summary_label] % [ @collection.offset + 1, @collection.offset + @collection.length, @collection.total_entries ], :class => "summary")
    end

end


