FactoryBot.define do
  factory :notification do
    visitor_id    { FactoryBot.create(:user).id }
    visited_id    { FactoryBot.create(:user).id }
    action        { "comment" }
    checked       { true }
    association :post
    association :comment
    
  end
end
