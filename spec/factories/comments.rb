FactoryBot.define do
  factory :comment do 
    body "testing comment"
    association :commentable, factory: :article
    user
  end
end
