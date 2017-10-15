class FeatureFlag < ApplicationRecord
  belongs_to :namespace_flag
  validates_presence_of :name
  store_accessor :environments, :development, :integration, :staging, :production
end
