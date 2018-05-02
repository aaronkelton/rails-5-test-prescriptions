class Task < ApplicationRecord
  belongs_to :project

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

  def self.completed; where(status: "completed"); end
  def self.large; where("size > 3"); end
  def self.most_recent; where("completed_at DESC"); end
  def self.recent_done_and_large; completed.large.most_recent.limit(5); end
end
