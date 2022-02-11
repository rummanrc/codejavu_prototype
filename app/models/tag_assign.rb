class TagAssign < ApplicationRecord
  belongs_to :tag
  belongs_to :snippet
end
