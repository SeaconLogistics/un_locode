class Schema < ActiveRecord::Migration

  def change
    create_table :countries do |t|
      t.string :name
      t.string :country_code
    end

    create_table :places do |t|
      t.string :city_code
      t.string :full_name
      t.string :full_name_without_diacritics
      t.string :subdivision
      t.string :function_classifier
      t.string :status
      t.date :date
      t.string :iata_code
      t.string :coordinates
      t.integer :country_id
    end

    create_table :functions do |t|
      t.string :name
      t.string :funciton_id
    end

    create_table :places_functions do |t|
      t.string :place_id
      t.string :funciton_id
    end
  end
end

