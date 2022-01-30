class CreateSnippets < ActiveRecord::Migration[7.0]
  def change
    create_table :snippets do |t|
      t.belongs_to :user, index:true, foreign_key:true
      t.belongs_to :language, foreign_key:true
      t.text :snippet

      t.timestamps
    end
  end
end
