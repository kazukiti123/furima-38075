class CreateBuyAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :buy_addresses do |t|
      t.string :postal_code,            null: false
      t.integer :prefecture_id,         null: false
      t.string :city,                   null: false
      t.string :street_address,         null: false
      t.string :building
      t.string :phone_number,           null: false
      t.references :purchase_history,   foreign_key: true,null: false

      t.timestamps
    end
  end
end
