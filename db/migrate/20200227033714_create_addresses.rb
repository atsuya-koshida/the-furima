class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.string  :lastname,        null: false
      t.string  :firstname,       null: false
      t.string  :lastname_kana,   null: false
      t.string  :firstname_kana,  null: false
      t.string  :postal_code,     null: false
      t.string  :prefecture,      null: false
      t.string  :city,            null: false
      t.string  :house_num,       null: false
      t.string  :detail
      t.string  :tel_num
      t.references :user,         null: false, foreign_key: true
      t.timestamps
    end
  end
end
