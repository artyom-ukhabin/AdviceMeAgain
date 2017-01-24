FactoryGirl.define do
  factory :profile do
    user
    sequence(:name) { |n| "name_#{n}" }
    sequence(:city) { |n| "city_#{n}" }
    sequence(:info) { |n| "info_#{n}" }
  end
end