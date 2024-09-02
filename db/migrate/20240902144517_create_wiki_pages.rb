# frozen_string_literal: true

class CreateWikiPages < ActiveRecord::Migration[7.1]
  def change
    create_table :wiki_pages do |t|
      t.string :title
      t.text :content
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
