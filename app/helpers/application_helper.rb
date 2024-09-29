module ApplicationHelper
  def render_category_menu(categories)
    categories.each do |category|
      if category.subcategories.any?
        concat(content_tag(:li, class: "nav-item dropdown") do
          concat(link_to(category.description, "#", class: "nav-link dropdown-toggle", id: "navbarDropdown#{category.id}", role: "button", data: { bs_toggle: "dropdown" }, aria: { expanded: "false" }))

          # Recursão para subcategorias
          concat(content_tag(:ul, class: "dropdown-menu") do
            render_category_menu(category.subcategories)
          end)
        end)
      else
        concat(content_tag(:li, class: "nav-item") do
          concat(link_to(category.description, category_path(category, locale: I18n.locale), class: "dropdown-item"))
        end)
      end
    end
    nil
  end
end
