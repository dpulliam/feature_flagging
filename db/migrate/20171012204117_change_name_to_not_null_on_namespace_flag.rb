class ChangeNameToNotNullOnNamespaceFlag < ActiveRecord::Migration[5.1]
  def change
    change_column_null :namespace_flags, :name, false
  end
end
