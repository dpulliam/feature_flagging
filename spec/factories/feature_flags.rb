FactoryGirl.define do
  factory :feature_flag do
    name { Faker::Lorem.word }    
    namespace_flag_id nil
  end
end