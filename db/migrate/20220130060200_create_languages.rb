class CreateLanguages < ActiveRecord::Migration[7.0]
  def change
    create_table :languages do |t|
      t.string :name, limit: 32

      t.timestamps
    end
  end
end
