class Snippet < ApplicationRecord
  validates :title, :language_id, :snippet, presence: true
end
