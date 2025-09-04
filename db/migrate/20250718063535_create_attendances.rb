class CreateAttendances < ActiveRecord::Migration[7.0]
  def change
    create_table :attendances do |t|
      t.references :employee, null: false, foreign_key: true
      t.date :date
      t.string :status

      t.timestamps
    end
    add_index :attendances, [:employee_id, :date], unique: true
  end
end
