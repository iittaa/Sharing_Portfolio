FactoryBot.define do
  factory :stock do
    association :post
    user { post.user }
  end
end
