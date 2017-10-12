class NamespaceFlag < ApplicationRecord

  # has_many :feature_flags, dependent: :destroy

  validates_presence_of :name

  # def disabled? 
  #   feature_flags.each do |f|
  #     return false if f.disabled
  #   end
  #   return true
  # end
end
