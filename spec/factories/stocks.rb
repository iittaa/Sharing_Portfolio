FactoryBot.define do
  factory :stock do
    association :post
    user_id { post.user.id }
  end
end
