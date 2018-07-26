class AddOrderToTasks < ActiveRecord::Migration[5.1]
  def change
    change_table :tasks do |t|
      t.integer :project_order
    end
  end
end
