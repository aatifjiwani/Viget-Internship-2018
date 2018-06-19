FactoryBot.define do
  factory :comment do
    author "MyString"
    body "MyText"
    commentable_id 1
    commentable_type "MyString"
  end
end
