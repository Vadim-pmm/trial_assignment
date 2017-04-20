class CreateTasks < ActiveRecord::Migration[5.0]
  def change
    create_table :tasks do |t|
      t.references :group, foreign_key: true, index: true
      t.string :name
      t.string :description, default: 'Without description'
      t.date :deadline
      t.datetime :reported_at
      t.boolean :accepted, default: false
      t.string :comment_on_accept

      t.timestamps
    end
  end
end
