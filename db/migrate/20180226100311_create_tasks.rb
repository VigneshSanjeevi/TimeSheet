class CreateTasks < ActiveRecord::Migration[5.1]
  def change
    create_table :tasks do |t|
      t.integer :project_id
      t.date :date
      t.string :title
      t.string :desc      
      t.decimal :dur, precision: 4, scale: 2      
      t.timestamps
    end
  end
end
