class AddNameToNamespaceFlag < ActiveRecord::Migration[5.1]
  def change
    add_column :namespace_flags, :name, :string
  end
end
