FactoryGirl.define do
  factory :location do
    name {Faker::Lorem.characters(20)}
    code {Faker::Lorem.characters(8)}
  end
end
