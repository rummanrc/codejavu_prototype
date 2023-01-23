class Snippet < ApplicationRecord
  validates :title, :language_id, :snippet, presence: true
  has_many :urls, dependent: :delete_all
  has_many :tag_assigns, dependent: :delete_all
  has_many :tags, through: :tag_assigns
  belongs_to :language
  belongs_to :user
  accepts_nested_attributes_for :urls, allow_destroy: true
  accepts_nested_attributes_for :tag_assigns, allow_destroy: true
end
