class Event < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: :slugged

  belongs_to :organizers, class_name: "User"
  has_many :taggings
  has_many :tags, through: :taggings
end
