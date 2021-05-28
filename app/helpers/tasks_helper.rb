# frozen_string_literal: true

module TasksHelper
  def create_sort_link(column, title)
    sort_criteria_column = set_sort_criteria
    sort_order = switch_order
    direction = (column == sort_criteria_column && sort_order == 'asc') ? 'desc' : 'asc'
    link_to title, sort: column, direction: direction
  end
end
