class AddCityToFlights < ActiveRecord::Migration[6.1]
  def change
    add_reference :flights, :origin_city, references: :city, index: true
    add_foreign_key :flights, :cities, column: :origin_city_id

    add_reference :flights, :destination_city, references: :city, index: true
    add_foreign_key :flights, :cities, column: :destination_city_id
  end
end
