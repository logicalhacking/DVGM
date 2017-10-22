class CreateLectures < ActiveRecord::Migration[5.0]
  def change
    create_table :lectures do |t|
      t.string :name
      t.references :lecturer, foreign_key: true

      t.timestamps
    end
  end
end
