# frozen_string_literal: true

module TasksHelper
  def create_sort_link(column, title)
    truth_value = (column == set_sort_criteria && switch_order == 'asc')
    direction = truth_value ? 'desc' : 'asc'
    link_to title, sort: column, direction: direction
  end
end
