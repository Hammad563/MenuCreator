FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "alex#{n}@google.com"}
    password { "password" }
  end
end
