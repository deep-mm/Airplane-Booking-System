class AddReservationToBaggages < ActiveRecord::Migration[6.1]
  def change
    add_reference :baggages, :reservation, null: false, foreign_key: true
  end
end
