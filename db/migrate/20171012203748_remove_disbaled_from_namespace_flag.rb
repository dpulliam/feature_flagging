class RemoveDisbaledFromNamespaceFlag < ActiveRecord::Migration[5.1]
  def change
    remove_column :namespace_flags, :disabled
  end
end
