class AddViewCountToArticles < ActiveRecord::Migration[5.0]
  def change
    add_column :articles, :view_count, :integer
  end
end
