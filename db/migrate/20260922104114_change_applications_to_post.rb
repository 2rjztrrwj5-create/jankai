class ChangeApplicationsToPost < ActiveRecord::Migration[8.0]
  def change
    remove_reference :applications, :group, foreign_key: true
    add_reference :applications, :post, foreign_key: true
  end
end
