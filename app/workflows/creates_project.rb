class CreatesProject
  attr_accessor :name, :task_string, :project

  def initialize(name: "", task_string: "")
    @name = name
    @task_string = task_string || ""
    @success = false
  end

  def success?
    @success
  end

  def build
    self.project = Project.new(name: name)
    project.tap {|p|p.tasks = convert_string_to_tasks}
  end

  def create
    build
    result = project.save! #returns true if successful
    @success = result
  end

  def convert_string_to_tasks
    task_string.split("\n").map do |one_task|
      title, size_string = one_task.split(":")
      Task.new(title: title, size: size_as_integer(size_string))
    end
  end

  def size_as_integer(size_string)
    size_string.blank? ? 1 : [size_string.to_i, 1].max
  end
end
