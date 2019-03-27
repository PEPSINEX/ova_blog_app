# == Schema Information
#
# Table name: users
#
#  id              :bigint(8)        not null, primary key
#  admin           :boolean          default(FALSE), not null
#  email           :string           default(""), not null
#  is_enabled      :boolean          default(TRUE), not null
#  name            :string           default(""), not null
#  password_digest :string           default(""), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#

class User < ApplicationRecord
  before_save :set_not_admin

  has_secure_password

  has_one_attached :image
  has_many :blogs
  has_many :articles

  validates :name, presence: true, length: { minimum: 4 }
  validates :email, presence: true, uniqueness: true, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :password, length: { minimum: 8 }
  validate :validate_image

  private

  def set_not_admin
    self.admin = false
  end

  def validate_image
    return unless image.attached?
    
    if image.blob.byte_size > 5.megabytes && !jpg_or_png?
      image.purge
      errors.add(:image, I18n.t('errors.messages.too_large'))
      errors.add(:image, I18n.t('errors.messages.not_jpg_or_png'))
    elsif image.blob.byte_size > 5.megabytes
      image.purge
      errors.add(:image, I18n.t('errors.messages.too_large'))
    elsif !jpg_or_png?
      image.purge
      errors.add(:image, I18n.t('errors.messages.not_jpg_or_png'))
    end
  end
  
  def jpg_or_png?
    %w(image/jpeg image/png).include?(image.blob.content_type)
  end
end