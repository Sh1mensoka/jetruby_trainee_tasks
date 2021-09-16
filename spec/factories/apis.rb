FactoryBot.define do
  factory :api do
    trait :mapbox do
      name { 'MapboxCalculator' }
    end

    trait :bing do
      name { 'BingCalculator' }
    end

    trait :distancematrix do
      name { 'DistanceMatrixCalculator' }
    end

    trait :on do
      is_on { true }
    end

    trait :off do
      is_on { false }
    end
  end
end