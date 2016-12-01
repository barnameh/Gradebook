class CreateStudents < ActiveRecord::Migration[5.0]
  def change
    create_table :students do |t|
      t.integer :user_id
      t.integer :teacher_id
      t.integer :grade
      t.string  :status

      t.timestamps
    end
  end
end
