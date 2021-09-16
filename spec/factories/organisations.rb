FactoryBot.define do
  factory :organisation do
    trait :foo do
      name { 'Foo' }
    end

    trait :bar do
      name { 'Bar' }
    end
  end
end