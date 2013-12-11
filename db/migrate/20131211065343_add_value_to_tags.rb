class AddValueToTags < ActiveRecord::Migration
  def change
    change_table :tags do |t|
      t.integer :index_value, default: 0
    end
  end
end
