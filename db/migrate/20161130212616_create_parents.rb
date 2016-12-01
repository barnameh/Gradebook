class CreateParents < ActiveRecord::Migration[5.0]
  def change
    create_table :parents do |t|
      t.integer  :user_id
      t.integer  :student_id
      t.string   :phone

      t.timestamps
    end
  end
end
