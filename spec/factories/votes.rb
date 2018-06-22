FactoryBot.define do
  factory :vote do
    association :voteable, factory: :article
    user
    value 1
  end
end
