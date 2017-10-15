class NamespaceFlag < ApplicationRecord
  has_many :feature_flags, dependent: :destroy
  validates_presence_of :name

  def enabled?(environment)
    case environment
    when 'development'
      development
    when 'integration'
      integration
    when 'staging'
      staging
    when production
      production
    else
      false
    end
  end
end
