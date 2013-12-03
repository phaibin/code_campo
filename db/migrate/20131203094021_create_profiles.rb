class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :name
      t.string :url
      t.string :description
      t.references :user
      t.timestamps
    end
  end
end
