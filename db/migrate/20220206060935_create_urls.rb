class CreateUrls < ActiveRecord::Migration[7.0]
  def change
    create_table :urls do |t|
      t.belongs_to :snippet, foreign_key:true
      t.text :url

      t.timestamps
    end
  end
end
