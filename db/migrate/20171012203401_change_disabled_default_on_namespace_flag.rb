class ChangeDisabledDefaultOnNamespaceFlag < ActiveRecord::Migration[5.1]
  def change
    change_column_default :namespace_flags, :disabled, from: true, to: false
  end
end