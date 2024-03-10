class CreateTutorials < ActiveRecord::Migration[7.0]
  def change
    create_table :tutorials do |t|
      t.string :title
      t.text :description
      t.references :user, null: false, foreign_key: true
      t.string :link
      t.string :image_link

      t.timestamps
    end
  end
end
