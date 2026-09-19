class CreateAdminSessions < ActiveRecord::Migration[8.0]
  def change
    create_table :admin_sessions do |t|
      t.references :admin, null: false, foreign_key: true

      t.timestamps
    end
  end
end
