# frozen_string_literal: true

module TasksHelper
  def create_sort_link(column, title)
    direction = sorted_with_asc?(column) ? 'desc' : 'asc'
    link_to title, { sort: column, direction: direction }, class: 'btn btn-outline-primary btn-sm'
  end

  def sorted_with_asc?(column)
    current_sort_column == column && current_sort_order == 'asc'
  end
end
