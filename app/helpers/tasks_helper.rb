# frozen_string_literal: true

module TasksHelper
  def create_sort_link(column, title)
    direction = (column == sort_criteria_column && switch_order == 'asc') ? 'desc' : 'asc'
    link_to title, sort: column, direction: direction
  end
end
