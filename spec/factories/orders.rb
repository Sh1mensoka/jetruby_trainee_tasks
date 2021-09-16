FactoryBot.define do
  factory :order do
    name { 'Test' }
    s_name { 'Test' }
    patronymic { 'Test' }
    phone { 'Test' }
    email { 'Test' }
    weight { 1 }
    length { 1 }
    width { 1 }
    height { 1 }
    dep_address { 'Norilsk' }
    arr_address { 'Moscow' }
  end
end
