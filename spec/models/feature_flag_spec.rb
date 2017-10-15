require 'rails_helper'

RSpec.describe FeatureFlag, type: :model do
  it { should belong_to(:namespace_flag) }
end
