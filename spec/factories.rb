FactoryGirl.define do
  factory :user do
    username "Pekka"
    password "Foobar1"
    password_confirmation "Foobar1"
  end

  factory :rating do
    score 10
  end

  factory :rating2, class: Rating do
    score 20
  end

  factory :brewery do
    name "Sinebrychoff"
    year 1819
    active true
  end

  factory :beer do
    name "Hardcore IPA"
    brewery
    style
  end

  factory :style do
    name "IPA"
    description "N/A"
  end
end
