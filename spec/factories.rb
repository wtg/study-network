FactoryGirl.define do 
  factory :user do
    username "testuser"
    real_name "Test User"
    email "testuser@rpi.edu"
    year "Junior"
    is_admin false
    inactive false
  end

  factory :course do
    title "RCOS"
    crn "57324"
    abrev_name "CSCI"
    level "4963"
  end
end