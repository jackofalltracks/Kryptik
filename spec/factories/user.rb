FactoryGirl.define do
  factory :user do 
    email "thefounder@detroitrails.co"
    password "please1"
    confirmation_token 1082312812712424
    first_name "Malachai"
    last_name "Gonzales"
    sex "Male"
    city "Mexico City"
    state "Federal District"
    zipcode "06500"
    country "Mexico"
    created_at 5.days.ago
    updated_at Date.yesterday
    id 1
    # bands [Band.create(name: "Detroit Rails", bio: "The best in your Mommma house")]
  end
end