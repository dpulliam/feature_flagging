require 'rails_helper'

RSpec.describe 'Feature Flags API' do

  let!(:namespace_flag) { create(:namespace_flag) }
  let!(:feature_flag)   { create(:feature_flag, name: 'this is fucking bullshit, fuck you factorygirl', namespace_flag_id: namespace_flag.id) }
  
  describe 'GET namespace_flag_feature_flags_path' do
    context 'when namespace_flag exists' do

      before do
        get namespace_flag_feature_flags_path namespace_flag
        @json = JSON.parse(response.body)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(:ok)
      end

      it 'returns all feature_flags items' do
        expect(@json.size).to eq(1)
      end
    end

    context 'when a namespace_flag does not exist' do
      before do
        get namespace_flag_feature_flags_path namespace_flag_id: 0
        @json = JSON.parse(response.body)
      end

      it 'returns :not_found' do
        expect(response).to have_http_status(:not_found)
      end

      it 'returns a not found message' do
        expect(@json['error']).to eq("Couldn't find NamespaceFlag with 'id'=0")
      end
    end
  end

  describe 'GET namespace_flag_feature_flag_path with feature_flag' do
    context 'when feature_flag exists' do
      before do
        get namespace_flag_feature_flag_path namespace_flag, feature_flag
        @json = JSON.parse(response.body)
      end

      it 'returns status :ok' do
        expect(response).to have_http_status(:ok)
      end

      it 'returns the feature_flag' do
        expect(@json['id']).to eq(feature_flag.id)
      end
    end

    context 'when a feature_flag does not exist' do
      before do
        get namespace_flag_feature_flag_path namespace_flag, id: 0
      end

      it 'returns status :not_found' do
        expect(response).to have_http_status(:not_found)
      end

      it 'returns a not found error message' do
        expect(response.body).to include("Couldn't find FeatureFlag")
      end
    end
  end

  describe 'POST namespace_flag_feature_flags_path with new feature_flag' do
    let(:valid_attributes) { { name: 'sub_feature' } }

    context 'with valid_attributes' do
      before do
        post namespace_flag_feature_flags_path namespace_flag, params: valid_attributes
        @json = JSON.parse(response.body)
      end

      it 'returns status :created' do
        expect(response).to have_http_status(:created)
      end
    end

    context 'when invalid_attributes' do
      let(:invalid_attributes) { { name: nil } }

      before do
        post namespace_flag_feature_flags_path namespace_flag,params: invalid_attributes
      end

      it 'returns status :unprocessable_entity' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Name can't be blank/)
      end
    end
  end

  describe 'PUT namespace_flag_feature_flags_path with feature_flag' do
    let(:valid_attributes) { { name: 'sub_feature' } }

    context 'when feature_flag exists' do
      before do
        put namespace_flag_feature_flag_path namespace_flag, feature_flag, params: valid_attributes
      end

      it 'returns status :no_content' do
        expect(response).to have_http_status(:no_content)
      end

      it 'updates the item' do
        flag = FeatureFlag.find(feature_flag.id)
        expect(flag.name).to eq('sub_feature')
      end
    end

    context 'when feature_flag does not exist' do
      before do
        put namespace_flag_feature_flag_path namespace_flag, id: 0 
      end

      it 'returns status :not_found' do
        expect(response).to have_http_status(:not_found)
      end

      it 'returns a not found error message' do
        expect(response.body).to include("Couldn't find FeatureFlag")
      end
    end
  end

  describe 'DELETE namespace_flag_feature_flag with feature_flag' do
    before do 
      delete namespace_flag_feature_flag_path namespace_flag, feature_flag 
    end

    it 'returns status :no_content' do
      expect(response).to have_http_status(:no_content)
    end
  end
end