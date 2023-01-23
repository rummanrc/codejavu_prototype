class CreateTagAssigns < ActiveRecord::Migration[7.0]
  def change
    create_table :tag_assigns do |t|
      t.belongs_to :tag, null: false, foreign_key: true
      t.belongs_to :snippet, null: false, foreign_key: true
      #add_index :tag_assigns, [ :tag_id, :snippet_id], :unique => true, :name => 'by_tag_and_snippet_unique_combo'

      t.timestamps
    end
  end
end
