class AddPasswordToUser < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.string :password_digest
      t.string :access_token
      t.string :locale, default: I18n.locale.to_s
    end
  end
end
