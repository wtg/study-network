FactoryGirl.define do 
  factory :user do
    username "testuser"
    real_name "Test User"
    email "testuser@rpi.edu"
    year "Junior"
    is_admin false
    inactive false
  end
end