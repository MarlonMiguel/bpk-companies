module CategoriesHelper
  def render_categories(categories, level = 0, rendered_ids = [], parent_id = nil, product_counts = {})
    categories.reject { |category| rendered_ids.include?(category.id) }.map do |category|
      rendered_ids << category.id
      product_count = product_counts[category.id] || 0  # Pega a contagem ou 0 se não houver produtos

      content_tag(:div, class: "form-check subcategory", style: "margin-left: #{level}px;") do
        check_box_tag(
          'category_ids[]',
          category.id,
          params[:category_ids]&.include?(category.id.to_s),
          id: "category_#{category.id}",
          class: 'form-check-input parent-category',
          data: { category_id: category.id, parent_id: parent_id }
        ) +
        label_tag("category_#{category.id}", "#{category.description} (#{product_count})", class: 'form-check-label') +  # Adiciona a contagem ao lado do nome
        render_categories(category.subcategories, level + 1, rendered_ids, category.id, product_counts) # Passa o hash de contagens
      end
    end.join.html_safe
  end

  def render_category_badges(category, level = 0)

    badge_colors = ['bg-primary', 'bg-secondary', 'bg-success', 'bg-danger', 'bg-warning', 'bg-info']
    color_class = badge_colors[level % badge_colors.length]

    content_tag(:span, category.description, class: "badge #{color_class}") +
      (category.parent ? render_category_badges(category.parent, level + 1) : '').html_safe
  end
end
