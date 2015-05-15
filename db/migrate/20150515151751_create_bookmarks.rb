class CreateBookmarks < ActiveRecord::Migration
  def change
    create_table :bookmarks do |t|
      t.string :url
      t.string :name
      t.references :user, index: true
      t.references :topic, index: true

      t.timestamps
    end
  end
end
