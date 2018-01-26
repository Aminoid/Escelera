class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :car
  enum status: [:available,:reserved,:checkedOut,:returned]
  after_initialize :set_status, :if => :new_record?

  validates :pickup_time, :presence => true
  validates :return_time, :presence => true

  def set_status
    self.status ||= :reserved if self.status.nil?
  end
end
