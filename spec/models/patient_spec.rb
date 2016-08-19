require 'rails_helper'

RSpec.describe Patient, type: :model do
  it "is invalid without a first_name" do
    patient = build(:patient, first_name: nil)
    patient.valid?
    expect(patient.errors[:first_name]).to include("can't be blank")
  end

  it "is invalid with a first_name has more than 30 characters" do
    patient = build(:patient, first_name: 'a' * 31)
    patient.valid?
    expect(patient.errors[:first_name]).to include("30 characters is the maximum allowed")
  end

  it "is invalid without a last_name" do
    patient = build(:patient, last_name: nil)
    patient.valid?
    expect(patient.errors[:last_name]).to include("can't be blank")
  end

  it "is invalid with a last_name has more than 30 characters" do
    patient = build(:patient, last_name: 'b'*31)
    patient.valid?
    expect(patient.errors[:last_name]).to include("30 characters is the maximum allowed")
  end

  it "is invalid with a middle_name has more than 10 characters" do
    patient = build(:patient, middle_name: 'm'*11)
    patient.valid?
    expect(patient.errors[:middle_name]).to include("10 characters is the maximum allowed")
  end

  it "is invalid without a status" do
    patient = build(:patient, status: nil)
    patient.valid?
    expect(patient.errors[:status]).to include("can't be blank")
  end

  it "is invalid with a status has a value other than 'Initial', 'Referred', 'Treatment', 'Closed'" do
    patient = build(:patient, status: 'new')
    patient.valid?
    expect(patient.errors[:status]).to include("new is not a valid status")
  end

  it "is invalid with a gender has a value other than 'NA', 'Male', 'Female'" do
    patient = build(:patient, gender: 'M')
    patient.valid?
    expect(patient.errors[:gender]).to include("M is not a valid gender")
  end

  it "is invalid without a location_id" do
    patient = build(:patient, location_id: nil)
    patient.valid?
    expect(patient.errors[:location_id]).to include("can't be blank")
  end

  it "is valid with a first_name, last_name, status and location_id" do
    expect(build(:patient)).to be_valid
  end

  it "returns a patient's full name as a string" do
    patient = build(:patient)
    expect(patient.full_name).to eq "#{patient.last_name}, #{patient.first_name} #{patient.middle_name}"
  end

  it "returns a patient's Medical Record Number as a string" do
    expect(create(:patient).medical_record_number).to eq "MR000001"
  end

  it "returns a patient's age" do
    expect(build(:patient, date_of_birth: 20.years.ago).age).to eq 20
  end
end

describe "filter patients with stauts 'Treatment'" do
  before(:each) do
    @john = create(:patient, status: 'Treatment')
    @smith = create(:patient, first_name: 'smith')
    @jones = create(:patient, first_name: 'jones', status: 'Treatment')
  end

  context "with matching status" do
    it "returns patients that match" do
      expect(Patient.onTreatment).to eq [@john, @jones]
    end
  end

  context "with non-matching status" do
    it "omits patients that do not match" do
      expect(Patient.onTreatment).not_to include @smith
    end
  end
end
