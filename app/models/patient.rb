class Patient < ActiveRecord::Base
  belongs_to :location

  validates :first_name, presence: true, length: {maximum: 30, too_long: "%{count} characters is the maximum allowed"}
  validates :middle_name, length: {maximum: 10, too_long: "%{count} characters is the maximum allowed"}
  validates :last_name, presence: true, length: {maximum: 30, too_long: "%{count} characters is the maximum allowed"}
  validates :gender, inclusion: {in: ["Not available", "Male", "Female"], message: "%{value} is not a valid gender"}
  validates :status, presence: true, inclusion: {in: %w(Initial Referred Treatment Closed), message: "%{value} is not a valid status"}
  validates :location_id, presence: true

  scope :onTreatment, -> {where(status: 'Treatment')}
  scope :not_deleted, -> {where(deleted: false)}

  def full_name
    "#{last_name}, #{first_name} #{middle_name}"
  end

  def age
    (Date.today.to_s(:number).to_i - date_of_birth.to_s(:number).to_i)/1e4.to_i
  end

  def medical_record_number
    "MR#{'%06d' % id}"
  end
end
