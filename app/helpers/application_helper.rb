module ApplicationHelper
  def render_category_menu(categories)
    categories.each do |category|
      if category.subcategories.any?
        concat(content_tag(:li, class: "dropdown-submenu", data: { controller: "dropdown" }) do
          concat(content_tag(:span, category.description, class: "dropdown-toggle", data: { action: "click->dropdown#toggle" }))
          
          concat(content_tag(:ul, class: "dropdown-menu", style: "display: none;") do
            render_category_menu(category.subcategories)
          end)
        end)
      else
        concat(content_tag(:li) do
          concat(content_tag(:span, category.description))
        end)
      end
    end
    nil
  end
end
