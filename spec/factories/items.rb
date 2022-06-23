FactoryBot.define do
  factory :item do
    name {Faker::Lorem.words}
    explanation {Faker::Lorem.characters}
    price {Faker::Number.between(from: 300, to: 9999999)}
    states_id {Faker::Number.between(from: 2, to: 7)}
    postage_id {Faker::Number.between(from: 2, to: 3)}
    prefecture_id {Faker::Number.between(from: 2, to: 48)}
    send_time_id {Faker::Number.between(from: 2, to: 4)}
    category_id {Faker::Number.between(from: 2, to: 11)}
    association :user
    after(:build) do |message|
      message.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
