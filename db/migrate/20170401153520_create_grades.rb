class CreateGrades < ActiveRecord::Migration[5.0]
  def change
    create_table :grades do |t|
      t.references :lecture, foreign_key: true
      t.references :student, foreign_key: true
      t.numeric :grade
      t.string :comment

      t.timestamps
    end
  end
end
