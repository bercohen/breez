class CreateCharges < ActiveRecord::Migration[5.0]
  def change
    create_table :charges do |t|
      t.boolean :paid, default: true
      t.integer :amount
      t.string :currency
      t.boolean :refunded
      t.references :order, foreign_key: true
      t.boolean :disputed, default: false

      t.timestamps
    end
  end
end
