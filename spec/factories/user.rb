FactoryBot.define do
  factory :user do
    username  "demouser"
    email     "demo@viget.com"
    password_digest "testpassword"
  end
end