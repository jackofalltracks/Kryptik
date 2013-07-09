# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :status do
    user_id 1
    content "MyText"
    index ""
  end
end
