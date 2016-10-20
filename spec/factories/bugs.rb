FactoryGirl.define do
  factory :bug do
    application_token "LeNU-ImvJLOLCxu5cwrrFg"
    status "In-progress"
    priority "major"
    comment "This is a test comment"    
    number 1
  end
end
