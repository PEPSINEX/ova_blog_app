3.times do |n|
  User.create!(
    name: "test#{n+1}",
    email: "test#{n+1}@test.com",
    password: 'password',
    password_confirmation: 'password'
  )
end

3.times do |n|
  user_id = %w(1 1 2)
  Blog.create!(
    title: "blog_test#{n}",
    description: "test#{n}@test.com",
    user_id: user_id[n]
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
