class RemoveFrozenFromUser < ActiveRecord::Migration
  def change
    remove_column :users, :frozen, :boolean
  end
end
