5.times do
  Feedback.create!(
    email: Faker::Internet.email,
    text: Faker::Lorem.paragraph(2, false, 4)
  )
end
