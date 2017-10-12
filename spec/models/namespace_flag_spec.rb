require 'rails_helper'

RSpec.describe NamespaceFlag, type: :model do
  # it { should have_many(:feature_flags).dependent(:destroy) }
  # it 'should return disabled when any feature flag is diabled' do
  #   expect(disabled).to be_false
  # end
  # it 'shou;d return true when all feature flags are enabled' do   
  #   expect(disabled).to be_true
  # end
  
  it { should validate_presence_of(:name) }
end
