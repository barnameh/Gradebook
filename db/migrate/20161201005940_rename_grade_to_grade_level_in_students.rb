class RenameGradeToGradeLevelInStudents < ActiveRecord::Migration[5.0]
  def change
    change_table :students do |t|
      t.rename :grade, :grade_level
    end
  end
end
