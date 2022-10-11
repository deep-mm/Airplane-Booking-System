class RenameReservationsClassColumn < ActiveRecord::Migration[6.1]
  def change
    rename_column :reservations, :class, :reservation_class
  end
end
