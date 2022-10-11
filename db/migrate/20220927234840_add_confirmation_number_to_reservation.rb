class AddConfirmationNumberToReservation < ActiveRecord::Migration[6.1]
  def change
    add_column :reservations, :confirmation_number, :string
  end
end
