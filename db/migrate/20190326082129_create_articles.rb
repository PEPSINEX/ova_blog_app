class CreateArticles < ActiveRecord::Migration[5.2]
  def change
    create_table :articles do |t|
      t.string :title, null: false, default: ""
      t.text :content, null: false, default: ""
      t.references :user, foreign_key: true
      t.references :blog, foreign_key: true
      t.boolean :is_published, null: false, default: false

      t.timestamps
    end
  end
end
