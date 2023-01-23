class TagAssign < ApplicationRecord
  belongs_to :tag
  belongs_to :snippet

  validates_uniqueness_of :tag_id, :scope => :snippet_id, :message => "one tag only once"
end
