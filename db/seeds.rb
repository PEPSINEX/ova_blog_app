3.times do |n|
  User.create!(
    name: "test#{n}",
    email: "test#{n}@test.com",
    password: 'password',
    password_confirmation: 'password'
  )
end

# 管理ユーザー作成
User.skip_callback(:save, :before, :set_not_admin)
User.create!(
  name: 'admin_test',
  email: 'admin_test@test.com',
  password: 'password',
  password_confirmation: 'password',
  admin: true
)
