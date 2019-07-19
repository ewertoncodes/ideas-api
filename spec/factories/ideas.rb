FactoryBot.define do
  factory :idea do
    title { Faker::Lorem.word }
    body { Faker::Lorem.paragraph(2) }
  end
end