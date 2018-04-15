class CreateTaggings < ActiveRecord::Migration[5.1]
  def change
    create_table :taggings do |t|
      t.references :tag, foreign_key: true
      t.references :contact, foreign_key: true

      t.timestamps
    end
    # add_index :taggings, :tag_id
    # add_index :taggings, :contact_id
  end
end
