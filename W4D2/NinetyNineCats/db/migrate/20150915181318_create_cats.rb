class CreateCats < ActiveRecord::Migration
  def change
    create_table :cats do |t|
      t.string :name, null: false
      t.date :birth_date, null: false
      t.string :color, null: false, inclusion: ["Black", "White", "Calico"]
      t.string :sex, null: false, limit: 1, inclusion: ["M", "F"]
      t.text :description, null: false

      t.timestamps
    end
  end
end
