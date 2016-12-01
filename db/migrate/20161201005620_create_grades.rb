class CreateGrades < ActiveRecord::Migration[5.0]
  def change
    create_table :grades do |t|
      t.integer   :student_id
      t.string    :assignment_name
      t.datetime  :assignment_date
      t.string    :grade

      t.timestamps
    end
  end
end
