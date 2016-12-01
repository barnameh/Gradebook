class AddGradeToGrades < ActiveRecord::Migration[5.0]
  def change
    add_column :grades, :student_id, :integer
    add_column :grades, :assignment_name, :string
    add_column :grades, :assignment_date, :datetime
    add_column :grades, :grade, :string
  end
end
