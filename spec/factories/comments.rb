FactoryBot.define do
  factory :comment do
    association :post
    user_id   { post.user.id }
    content   { Faker::Lorem.sentence }
  end
end