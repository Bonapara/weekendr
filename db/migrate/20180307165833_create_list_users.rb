class CreateListUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :list_users do |t|
      t.references :bookmark, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
