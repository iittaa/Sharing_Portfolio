FactoryBot.define do
  factory :like do
    association :post
    user_id { post.user.id }
  end
end
