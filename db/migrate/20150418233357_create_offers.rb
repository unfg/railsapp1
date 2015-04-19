class CreateOffers < ActiveRecord::Migration
  def change
    create_table :offers do |t|
      t.string :title
      t.string :picture
      t.text :description
      t.string :url
      t.belongs_to :company, index: true

      t.timestamps null: false
    end
  end
end
