FactoryBot.define do
  factory :order do
    name { 'Test' }
    s_name { 'Test' }
    patronymic { 'Test' }
    phone { 'Test' }
    email { 'Test' }
    weight { 12 }
    length { 120 }
    width { 120 }
    height { 120 }
    dep_address { 'Test' }
    arr_address { 'Test' }
  end
end
