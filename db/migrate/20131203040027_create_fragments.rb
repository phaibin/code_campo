class CreateFragments < ActiveRecord::Migration
  def change
    create_table :fragments do |t|
      t.string :home_mainbar_bottom
      t.string :home_sidebar_bottom
      t.string :topics_sidebar_bottom
      t.string :footer
      t.references :site
      t.timestamps
    end
  end
end
