class AddIndexToEventAddress < ActiveRecord::Migration
  def change
    add_index :events, :address
  end
end
