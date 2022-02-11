class Tag < ApplicationRecord
  has_many :tag_assigns
  has_many :snippets, through: :tag_assigns
end
