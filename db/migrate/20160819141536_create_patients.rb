class CreatePatients < ActiveRecord::Migration
  def change
    create_table :patients do |t|
      t.string :first_name, null: false, limit: 30
      t.string :middle_name, limit: 10
      t.string :last_name, null: false, limit: 30
      t.date :date_of_birth
      t.string :gender, default: 'Not available'
      t.string :status, null: false, default: 'Initial'
      t.references :location, index: true, foreign_key: true
      t.integer :view_count, default: 0
      t.boolean :deleted, default: false

      t.timestamps null: false
    end
  end
end
