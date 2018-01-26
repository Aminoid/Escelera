class User < ApplicationRecord

  has_many :bookings

  enum role: [:user, :admin, :superadmin]
  after_initialize :set_default_role, :if => :new_record?


  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :name, :presence => true

  def set_default_role
    self.role ||= :user if self.role.nil?
  end

end
