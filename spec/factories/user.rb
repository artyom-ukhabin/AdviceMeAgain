FactoryGirl.define do
  factory :user, aliases: [:user_without_role, :regular_user] do
    sequence(:email) { |n| "user_#{n}@test.com" }
    password 'password'
    confirmed_at Date.today

    factory :admin do
      email 'admin@test.com'
      password 'password'
      role :admin
    end

    factory :user_with_profile do
      association :profile, strategy: :build
    end
  end
end