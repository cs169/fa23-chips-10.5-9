# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RepresentativesController,
               type: :controller do
  describe 'GET #show' do
    before do
      @representative_instance = Representative.create(name: 'AB', ocdid: '1', title: 'Reptitle', street: 'Repstreet',
                                                       city: 'Repcity', state: 'Repstate', zip: 94_704, party: 'RepP',
                                                       photo: 'https://a1cf74336522e87f135f-2f21ace9a6cf0052456644b80fa06d4f.ssl.cf2.rackcdn.com/images/characters/large/2800/Joey-Tribbiani.Friends.webp')
    end

    it 'renders the show template' do
      get :show, params: { id: @representative_instance.id }
      expect(response).to render_template(:show)
    end

    it 'assigns representative attributes to instance variables' do
      get :show, params: { id: @representative_instance.id }
      expect(assigns(:rep_name)).to eq(@representative_instance.name)
      expect(assigns(:rep_ocdid)).to eq(@representative_instance.ocdid)
      expect(assigns(:rep_title)).to eq(@representative_instance.title)
    end

    it 'returns a 200 status code' do
      get :show, params: { id: @representative_instance.id }
      expect(response).to have_http_status(:ok)
    end
  end
end
