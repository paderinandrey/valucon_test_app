FactoryGirl.define do
  sequence :email do |n|
    "user#{n}@test.com"
  end

  factory :feedback do
    email
    text 'MyText'
  end

  factory :invalid_feedback, class: 'Feedback' do
    email ''
    text ''
  end
end
