FactoryGirl.define do
  factory :user do 
    email "thefounder@detroitrails.co"
    password "please1"
    confirmation_token 1082312812712424
    created_at 5.days.ago
    updated_at Date.yesterday
  end
end