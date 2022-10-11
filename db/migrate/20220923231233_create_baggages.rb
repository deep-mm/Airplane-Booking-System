class CreateBaggages < ActiveRecord::Migration[6.1]
  def change
    create_table :baggages do |t|
      t.decimal :weight
      t.decimal :cost

      t.timestamps
    end
  end
end
