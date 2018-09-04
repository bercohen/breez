class AddFixedPriceToLineItems < ActiveRecord::Migration[5.0]
  def change
    add_column :line_items, :fixed_price, :integer
  end
end
