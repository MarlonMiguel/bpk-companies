module ApplicationHelper
  def render_category(category, all_categories)
    content_tag(:li, class: "nav-item dropdown") do
      link_to(category.description, store_path(category_id: category.id), class: 'nav-link dropdown-toggle', data: { bs_toggle: 'dropdown' }) +
      render_subcategories(category, all_categories)
    end
  end
  
  def render_subcategories(category, all_categories, depth = 0)
    subcategories = all_categories.select { |cat| cat.parent_id == category.id }
  
    if subcategories.any?
      submenu_class = depth > 0 ? "submenu dropdown-menu" : "dropdown-menu" 
      content_tag(:ul, class: submenu_class) do
        subcategories.map do |subcategory|
          content_tag(:li) do
            link_to(subcategory.description, store_path(category_id: subcategory.id), class: 'dropdown-item') +
            render_subcategories(subcategory, all_categories, depth + 1) 
          end
        end.join.html_safe
      end
    else
      ''.html_safe 
    end
  end
end
