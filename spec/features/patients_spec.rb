require 'rails_helper'

feature 'Patient management with default locale' do
  scenario 'adds a new patient' do
    location = create(:location)
    visit root_path
    click_link 'New Patient'

    expect {
      fill_in 'First Name', with: 'Edward'
      fill_in 'Middle Name', with: 'G.'
      fill_in 'Last Name', with: 'Norton'
      click_button 'Submit'
    }.to change(Patient, :count).by(1)

    expect(current_path).to eq patient_path(Patient.last, locale: 'en')
    expect(page).to have_content "Edward"
  end

  scenario 'edit an existed patient' do
    location = create(:location)
    patient = create(:patient, location: location)

    visit root_url

    click_link('Edit')

    expect(current_path).to eq edit_patient_path(patient, locale: 'en')

    within 'h1' do
      expect(page).to have_content('Editing Patient')
    end

    expect {
      select 'Treatment', from: 'Status'
      click_button 'Submit'
    }.to_not change(Patient, :count)

    patient.reload
    expect(patient.status).to eq 'Treatment'
    expect(page).to have_content('Treatment')
  end

  scenario "show patient's location info" do
    location = create(:location)
    patient = create(:patient, location: location)

    visit root_url

    expect(page).to have_content(location.name)
    click_link(location.name)

    expect(current_path).to eq location_path(location, locale: 'en')
    expect(page).to have_content(patient.full_name)

  end

  scenario "delete a patient" do
    location = create(:location)
    patient = create(:patient, location: location)

    visit root_url
    click_link('Delete')

    expect(current_path).to eq patients_path(locale: 'en')
    expect(Patient.count).to eq 1
    expect(page).to_not have_content location.name
  end
end

feature 'Patient management with locale change' do
  scenario 'change the locale to zh', js: true do
    location = create(:location)
    patient = create(:patient, location: location)

    visit patients_path

    expect(page).to have_content 'English'

    select('中文', from: 'set_locale')

    expect(current_path).to eq patients_path(locale: 'zh')
    expect(page).to have_content '中文'
    expect(page).to have_content '初始'

    click_link '新建病人'
    expect(current_path).to eq new_patient_path(locale: 'zh')

    within 'h1' do
      expect(page).to have_content '新建病人'
    end
  end
end
