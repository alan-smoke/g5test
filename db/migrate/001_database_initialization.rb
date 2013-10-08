class DatabaseInitialization < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :first_name
      t.string :last_name
      t.string :guid
      t.string :email
      t.string :phone_number

      t.string :ip_address

      t.timestamps
    end

    create_table :tour_requests do |t|

      t.date :tour_date
      t.text :additional_questions
      t.belongs_to :customer

      t.timestamps
    end

    create_table :tour_ratings do |t|
      t.integer :rating
      t.belongs_to :tour_request

      t.timestamps
    end

    create_table :amenities do |t|
      t.string :name

      t.timestamps
    end

    create_table :amenities_tour_requests do |t|
      t.belongs_to :tour_request
      t.belongs_to :amenity
    end

  end
end