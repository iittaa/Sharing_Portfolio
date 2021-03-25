FactoryBot.define do
  # factory :モデル名 do
  # factory :testuser, class: User do  (モデル以外の名前をつける場合)
  factory :user do
    name                    { Faker::Name.name }
    email                   { Faker::Internet.free_email }
    password = Faker::Internet.password(min_length: 6)
    password                { password }
    password_confirmation   { password }
    profile                 { Faker::Lorem.sentence }
    twitter_link            { Faker::Internet.url }
    github_link            { Faker::Internet.url }
    user_image              {Rack::Test::UploadedFile.new(File.join(Rails.root, 'public/images/test.jpg'))}
  end
end
