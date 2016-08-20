module PatientsHelper
  def choices_for_gender
    Patient::ALL_GENDERS.map {|g| [t("patient.gender.#{g}"), g]}
  end

  def choices_for_status
    Patient::ALL_STATUSES.map {|s| [t("patient.status.#{s}"), s]}
  end

  def choices_for_location
    Location.all.map {|l| [l.name, l.id]}
  end
end
