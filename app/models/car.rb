class Car < ApplicationRecord
  has_many :bookings
  attr_accessor :status

  validates :model, :presence => true
  validates :manufacturer, :presence => true
  validates :number, :presence => true, :uniqueness => true
  validates :rate, :presence => true
  validates :style, :presence => true, :inclusion => { :in => ["Hatchback", "Sedan", "SUV"] }
  validates :location, :presence => true

end
