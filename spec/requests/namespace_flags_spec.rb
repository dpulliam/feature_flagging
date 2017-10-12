require 'rails_helper'

RSpec.describe 'Namespace Flag API', type: :request do 
  
  let!(:namespace_flag) { create(:namespace_flag) }

  describe 'GET namespace_flags_path' do
    before do
      get namespace_flags_path
      @json = JSON.parse(response.body)
    end

    it 'returns namespace_flags' do
      expect(@json.size).to eq(1)
    end

    it 'returns status ok' do 
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET namespace_flags_path with namespace_flag' do

    context 'when the namespace_flag exists' do

      before do
        get "#{namespace_flags_path}/#{namespace_flag.id}" 
        @json = JSON.parse(response.body)
      end

      it 'returns a namespace_flag' do
        expect(@json['id']).to eq(namespace_flag.id)
      end

      it 'returns status :ok' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when the record does not exist' do

      before do
        get "#{namespace_flags_path}/#{100}" 
        @json = JSON.parse(response.body)
      end

      it 'returns status :not_found' do
        expect(response).to have_http_status(:not_found)
      end

      it 'returns a not found message' do
        expect(@json['error']).to eq("Couldn't find NamespaceFlag with 'id'=100")
      end
    end
  end

  describe 'POST namespace_flag_path' do
    let(:valid_namespace_flag) { { name: 'super_feature' } }

    context 'when the request is valid' do
      before do 
        post namespace_flags_path, params: valid_namespace_flag 
        @json = JSON.parse(response.body)
      end

      it 'creates a namespace_flag' do
        expect(@json['name']).to eq('super_feature')
      end

      it 'returns status :created' do
        expect(response).to have_http_status(:created)
      end
    end

    context 'when the request is invalid' do
      before do 
        post namespace_flags_path, params: { name: nil } 
        @json = JSON.parse(response.body)
      end

      it 'returns status :unprocessable_entity' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns a validation failure' do
        expect(response.body).to match(/Validation failed: Name can't be blank/)
      end
    end
  end

  describe 'PUT namespace_flags_path ' do
    let(:valid_attributes) { { name: 'fun_feature' } }

    context 'when the record exists' do
      before { put "#{namespace_flags_path}/#{namespace_flag.id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code :no_content' do
        expect(response).to have_http_status(:no_content)
      end
    end
  end

  describe 'DELETE namespace_flags_path' do
    before do
      delete "#{namespace_flags_path}/#{namespace_flag.id}" 
    end

    it 'returns status code :no_content' do
      expect(response).to have_http_status(:no_content)
    end
  end
end




