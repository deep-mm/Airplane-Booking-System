class RenameFlightsClassColumn < ActiveRecord::Migration[6.1]
  def change
    rename_column :flights, :class, :flight_class
  end
end
