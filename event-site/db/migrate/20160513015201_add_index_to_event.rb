class AddIndexToEvent < ActiveRecord::Migration
  def change
    add_index :events, :title
  end
end
