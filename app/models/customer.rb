class Customer < ApplicationRecord
  validates :first_name, :last_name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  before_save { first_name.downcase! }
  before_save { last_name.downcase! }
  before_save { email.downcase! }
  has_one :vehicle
  accepts_nested_attributes_for :vehicle
  validates_associated :vehicle

  def self.import(file)

    CSV.foreach(file.path, headers: false) do |row|

      if row.size == 1
        parsed_line = row.join("").split("|").flatten
      else
        parsed_line = row
      end

      first_name, last_name, email, vehicle_type, vehicle_name, vehicle_length_ft = parsed_line

      customer = Customer.create(
        first_name: first_name,
        last_name: last_name,
        email: email
      )

      Vehicle.create(
        vehicle_type: vehicle_type.present? ? vehicle_type.downcase : nil,
        name: vehicle_name.present? ? vehicle_name.downcase : nil,
        length: vehicle_length_ft.to_f,
        customer: customer
      )
    end
  end

end
