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

  def render_category_accordion(category, all_categories, depth = 0)
    content_tag(:div, class: "accordion-item") do
      header_id = "heading#{category.id}"
      collapse_id = "collapse#{category.id}"
      subcategories = all_categories.select { |cat| cat.parent_id == category.id }
  
      # Cabeçalho da categoria
      content_tag(:h2, class: "accordion-header d-flex align-items-center justify-content-between", id: header_id) do
        # Link para redirecionamento
        #link_to(category.description, store_path(category_id: category.id), class: 'me-auto text-decoration-none') +
        link_to(category.description, store_path(category_id: category.id),
        class: 'me-auto text-decoration-none', 
        data: { turbo_frame: "products" }) +

        # Botão de expansão apenas se houver subcategorias
        if subcategories.any?
          button_tag(class: "accordion-button collapsed p-0 ms-2", type: "button",
                     "data-bs-toggle": "collapse", "data-bs-target": "##{collapse_id}",
                     "aria-expanded": "false", "aria-controls": collapse_id) do
          end
        else
          ''.html_safe # Sem botão para categorias sem subcategorias
        end
      end +
  
      # Conteúdo de subcategorias, renderizado apenas se houver subcategorias
      if subcategories.any?
        content_tag(:div, id: collapse_id, class: "accordion-collapse collapse #{'ps-3' if depth > 0}", "aria-labelledby": header_id) do
          content_tag(:div, class: "accordion-body") do
            render_subcategories_accordion(category, all_categories, depth + 1)
          end
        end
      else
        ''.html_safe
      end
    end
  end    

  def render_subcategories_accordion(category, all_categories, depth)
    subcategories = all_categories.select { |cat| cat.parent_id == category.id }

    if subcategories.any?
      subcategories.map do |subcategory|
        render_category_accordion(subcategory, all_categories, depth)
      end.join.html_safe
    else
      ''.html_safe
    end
  end

end
