class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
        t.string    "title"
        t.text      "description"
        t.string    "creator"
        t.datetime  "created_at"
        t.datetime  "updated_at"
    end
  end
end
