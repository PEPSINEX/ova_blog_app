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

require 'rails_helper'

RSpec.describe Article, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
