module PatientsHelper
  def choices_for_gender
    Patient::ALL_GENDERS.map {|g| [g, g]}
  end

  def choices_for_status
    Patient::ALL_STATUSES.map {|s| [s, s]}
  end

  def choices_for_location
    Location.all.map {|l| [l.name, l.id]}
  end
end
