class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :title, null: false
      t.text :description, null: false
      t.integer :condition_id, null: false
      t.integer :postage_id, null: false
      t.integer :prefecture_id, null: false
      t.integer :schedule_id, null: false
      t.integer :price, null: false
      t.references :user, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true
      t.integer :bought_user_id

      t.timestamps
    end

    add_index :items, :title
  end
end
