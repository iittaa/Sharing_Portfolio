FactoryBot.define do
  factory :post do
    name      { Faker::Lorem.word }
    content   { Faker::Lorem.sentence }
    point     { Faker::Lorem.sentence }
    image     { Rack::Test::UploadedFile.new(File.join(Rails.root, 'public/images/test.jpg')) }
    period    { Faker::Lorem.sentence }
    url       { Faker::Internet.url }
    association :user
  end
end
