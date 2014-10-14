class AddAsmGroupIdToEvent < ActiveRecord::Migration
  def change
    add_column :events, :asm_group_id, :integer, :limit => 2
  end
end
