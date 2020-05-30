25.times do
  User.create(
    email: Faker::Internet.email,
    password: 'password'
  )
end
