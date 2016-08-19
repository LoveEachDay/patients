FactoryGirl.define do
  factory :patient do
    first_name {Faker::Name.first_name}
    middle_name "J."
    last_name {Faker::Name.last_name}
    date_of_birth {Faker::Date.birthday}
    gender "Male"
    status "Initial"
    association :location
    view_count 0
    deleted false
  end
end
