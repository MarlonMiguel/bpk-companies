module PagesHelper
  def render_category_store(category, all_categories)
    content_tag(:li, class: "nav-item dropdown") do
      link_to("#{category.description} (#{category.products.size})", store_path(category_id: category.id), class: 'nav-link dropdown-toggle', data: { bs_toggle: 'dropdown' }) +
      render_subcategories(category, all_categories)
    end
  end

  def render_subcategories_store(parent_category, all_categories)
    subcategories = all_categories.select { |cat| cat.parent_id == parent_category.id }
    return if subcategories.empty?

    content_tag(:ul, class: "dropdown-menu") do
      subcategories.map do |subcategory|
        content_tag(:li) do
          link_to("#{subcategory.description} (#{subcategory.products.size})", store_path(category_id: subcategory.id), class: 'dropdown-item')
        end
      end.join.html_safe
    end
  end
end
