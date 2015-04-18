class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :title
      t.datetime :last_file_date
      t.string :last_file_name

      t.timestamps null: false
    end
  end
end
