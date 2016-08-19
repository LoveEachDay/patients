class Location < ActiveRecord::Base
  has_many :patients

  validates :name, presence: true, length: { maximum: 80, too_long: "%{count} characters is the maximum allowed" }
  validates :code, length: { maximum: 10, too_long: "%{count} characters is the maximum allowed" }
end
