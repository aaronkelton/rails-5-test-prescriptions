require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do
  describe "create" do
    it "calls the workflow with parameters" do
      workflow = instance_spy(CreatesProject, success?: true)
      allow(CreatesProject).to receive(:new).and_return(workflow)
      post :create, params: {project: {name: "Runway", tasks: "start something:2"}}
      expect(CreatesProject).to have_received(:new).with(name: "Runway", task_string: "start something:2")
    end
  end
end
