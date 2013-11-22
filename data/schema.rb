class Schema < ActiveRecord::Migration

  def change
    create_table :countries do |t|
      t.string :code
      t.string :name
    end

    create_table :locodes do |t|
      t.string :change_marker
      t.integer :country_id
      t.string :city_code
      t.string :name
      t.string :name_wo_diacritics
      t.string :alternative_name
      t.string :alternative_name_wo_diacritics
      t.string :sub_div
      t.boolean :port
      t.boolean :rail_terminal
      t.boolean :road_terminal
      t.boolean :airport
      t.boolean :postal_exchange_office
      t.boolean :inland_clearance_depot
      t.boolean :fixed_transport_functions
      t.boolean :border_crossing_function
      t.string :status
      t.date :date
      t.string :iata
      t.string :coordinates
      t.string :remarks
    end

    add_index(:locodes, [:country_id, :city_code, :change_marker])
  end
end

