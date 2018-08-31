class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.integer :total
      t.integer :tax
      t.integer :status
      t.references :customer, foreign_key: true
      t.references :cart, foreign_key: true

      t.timestamps
    end
  end
end
