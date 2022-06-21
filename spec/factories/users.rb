FactoryBot.define do
  factory :user do
    transient do
      person { Gimei.name }
    end

    nickname {Faker::Name.last_name}
    email {Faker::Internet.free_email}
    password {Faker::Lorem.characters(number: 6, min_alpha: 1, min_numeric: 1)
    }
    password_confirmation {password}
    first_name_kanji      { person.first.kanji }
    last_name_kanji       { person.last.kanji }
    first_name_kana       { person.first.katakana }
    last_name_kana        { person.last.katakana }
    birthday{Faker::Date.between(from: "1930-01-01", to: "2017-12-31")}
  end
end