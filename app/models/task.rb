class Task < ApplicationRecord
  belongs_to :project

  def previous_task
    project.tasks.find_by(project_order: project_order - 1)
  end

  def next_task
    project.tasks.find_by(project_order: project_order + 1)
  end

  def swap_order_with(other)
    other.project_order, self.project_order = project_order, other.project_order
    save
    other.save
  end

  def move_up
    swap_order_with(previous_task) unless first_in_project?
  end

  def move_down
    swap_order_with(next_task) unless last_in_project?
  end

  def mark_completed(date = Time.current)
    self.completed_at = date
  end

  def complete?
    completed_at.present?
  end

  def part_of_velocity?
    return false unless complete?
    completed_at > Project.velocity_length_in_days.days.ago
  end

  def points_toward_velocity
    part_of_velocity? ? size : 0
  end

  def first_in_project?
    return false unless project
    project.tasks.first == self
  end

  def last_in_project?
    return false unless project
    project.tasks.last == self
  end

  def self.completed; where(status: "completed"); end
  def self.large; where("size > 3"); end
  def self.most_recent; where("completed_at DESC"); end
  def self.recent_done_and_large; completed.large.most_recent.limit(5); end
end
