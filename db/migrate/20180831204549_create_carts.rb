class CreateCarts < ActiveRecord::Migration[5.0]
  def change
    create_table :carts do |t|
      t.integer :subtotal
      t.integer :status, default: 0
      t.integer :products_qty, default: 0
      t.references :customer, foreign_key: true

      t.timestamps
    end
  end
end
