class ProjectsController < ApplicationController
  def new
    @project = Project.new
  end

  def index
    @projects = Project.all
  end

  def create
    @workflow = CreatesProject.new(
      name: params[:project][:name],
      task_string: params[:project][:tasks])
    @workflow.create
    redirect_to projects_path
  end
end
