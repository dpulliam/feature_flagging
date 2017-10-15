class CreateFeatureFlags < ActiveRecord::Migration[5.1]
  def change
    create_table :feature_flags do |t|
      t.references :namespace_flag, foreign_key: true

      t.timestamps
    end
  end
end
