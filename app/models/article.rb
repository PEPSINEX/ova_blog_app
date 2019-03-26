# == Schema Information
#
# Table name: articles
#
#  id           :bigint(8)        not null, primary key
#  content      :text             default(""), not null
#  is_published :boolean          default(FALSE), not null
#  title        :string           default(""), not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  blog_id      :bigint(8)
#  user_id      :bigint(8)
#
# Indexes
#
#  index_articles_on_blog_id  (blog_id)
#  index_articles_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (blog_id => blogs.id)
#  fk_rails_...  (user_id => users.id)
#

class Article < ApplicationRecord
  belongs_to :user
  belongs_to :blog

  validates :title, presence: true, length: { maximum: 40 }
  validates :content, presence: true, length: { in: 390..400 }
  validates :is_published, inclusion: {in: [true, false]}

  belongs_to :user
  belongs_to :blog
end
