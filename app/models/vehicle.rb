class Vehicle < ApplicationRecord
  validates :vehicle_type, presence: true
  validates :length, presence: true, :numericality => { :only_integer => false, :greater_than => 0 }
  enum vehicle_type: {bicycle: 0, motorcycle: 1, atv: 2, car: 3, campervan: 4, rv: 5, sailboat: 6, motorboat: 7}
  belongs_to :customer
end
