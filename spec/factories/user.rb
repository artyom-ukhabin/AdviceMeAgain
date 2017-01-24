FactoryGirl.define do
  factory :user do
    sequence(:role) { |n| "role_#{n}" }

    factory :user_with_profile do
      association :profile, strategy: :build
    end
  end
end