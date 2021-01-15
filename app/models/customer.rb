class Customer < ApplicationRecord
  validates :first_name, :last_name, presence: true
  validates :vehicle_type, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :vehicle_length_ft, presence: true, :numericality => { :only_integer => false, :greater_than => 0 }
  enum vehicle_type: {bicycle: 0, motorcycle: 1, atv: 2, car: 3, campervan: 4, rv: 5, sailboat: 6, motorboat: 7}
  before_save { first_name.downcase! }
  before_save { last_name.downcase! }
  before_save { email.downcase! }

  def self.import(file)

    CSV.foreach(file.path, headers: false) do |row|

      if row.size == 1
        parsed_line = row.join("").split("|").flatten
      else
        parsed_line = row
      end

      first_name, last_name, email, vehicle_type, vehicle_name, vehicle_length_ft = parsed_line

      Customer.create(
        first_name: first_name,
        last_name: last_name,
        email: email,
        vehicle_type: vehicle_type.present? ? vehicle_type.downcase : nil,
        vehicle_name: vehicle_name.present? ? vehicle_name.downcase : nil,
        vehicle_length_ft: vehicle_length_ft.to_f
      )
    end
  end

end
