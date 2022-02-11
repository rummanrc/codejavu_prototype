class Snippet < ApplicationRecord
  validates :title, :language_id, :snippet, presence: true
  has_many :urls
  has_many :tag_assigns
  has_many :tags, through: :tag_assigns
  belongs_to :language
  belongs_to :user
end
