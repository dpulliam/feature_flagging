class CreateNamespaceFlags < ActiveRecord::Migration[5.1]
  def change
    create_table :namespace_flags do |t|
      t.boolean :disabled

      t.timestamps
    end
  end
end
