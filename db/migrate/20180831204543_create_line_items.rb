class CreateLineItems < ActiveRecord::Migration[5.0]
  def change
    create_table :line_items do |t|
      t.references :cart, foreign_key: true
      t.references :product, foreign_key: true
      t.integer :qty, default: 0

      t.timestamps
    end
  end
end
