class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.string :name
      t.string :s_name
      t.string :patronymic
      t.string :phone
      t.string :email
      t.numeric :weight
      t.numeric :length
      t.numeric :width
      t.numeric :height
      t.string :dep_address
      t.string :arr_address
      t.numeric :distance
      t.numeric :price

      t.timestamps
    end
  end
end
