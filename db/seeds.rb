User.create!(
  name: 'administrator',
  email: 'admin@example.com',
  password: ENV['ADMIN_PASS'],
  password_confirmation: ENV['ADMIN_PASS'],
  user_image: File.open('./app/assets/images/admin_image.png'),
  admin: true
)
