class Snippet < ApplicationRecord
  validates :title, :language_id, :snippet, presence: true
  has_many :url
  belongs_to :language
  belongs_to :user
end
