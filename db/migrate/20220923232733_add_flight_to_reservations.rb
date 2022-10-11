class AddFlightToReservations < ActiveRecord::Migration[6.1]
  def change
    add_reference :reservations, :flight, null: false, foreign_key: true
  end
end
