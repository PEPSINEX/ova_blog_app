# == Schema Information
#
# Table name: users
#
#  id              :bigint(8)        not null, primary key
#  admin           :boolean          default(FALSE), not null
#  email           :string           default(""), not null
#  name            :string           default(""), not null
#  password_digest :string           default(""), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#

FactoryBot.define do
  factory :user do
    name { "MyString" }
    email { "MyString" }
    password_digest { "MyString" }
  end
end
