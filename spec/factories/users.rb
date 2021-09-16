FactoryBot.define do
  factory :user do
    email { 'example@example.com' }
    password { 'password' }
    password_confirmation { 'password' }
    
    trait :operator do
      role { 'operator' }
    end

    trait :org_admin do
      role { 'org_admin' }
    end
  end
end
