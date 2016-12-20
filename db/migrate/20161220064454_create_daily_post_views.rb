class CreateDailyPostViews < ActiveRecord::Migration[5.0]
  def change
    create_table :daily_post_views do |t|
      t.belongs_to :post, foreign_key: true
      t.integer :views, default: 0
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
