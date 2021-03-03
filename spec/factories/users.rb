FactoryBot.define do
  # factory :モデル名 do
  # factory :testuser, class: User do  (モデル以外の名前をつける場合)
  factory :user do
    name                    { Faker::Name.name }
    email                   { Faker::Internet.free_email }
    password = Faker::Internet.password(min_length: 6)
    password                { password }
    password_confirmation   { password }
    password_digest         { password }
    profile                 { Faker::Lorem.sentence }
    
    github_link
    twitter_link
    admin                   { false }
  end
end
