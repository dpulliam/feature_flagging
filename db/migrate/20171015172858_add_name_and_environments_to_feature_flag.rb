class AddNameAndEnvironmentsToFeatureFlag < ActiveRecord::Migration[5.1]
  def change
    add_column :feature_flags, :name, :string
    add_column :feature_flags, :environments, :jsonb, null: false, default: {'development':false, 'integration':false, 'staging':false, 'production':false}
  end
end
