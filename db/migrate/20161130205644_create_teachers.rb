class CreateTeachers < ActiveRecord::Migration[5.0]
  def change
    create_table :teachers do |t|
      t.integer :user_id
      t.string  :subject
      t.string  :phone

      t.timestamps
    end
  end
end
