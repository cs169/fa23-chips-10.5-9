require 'rails_helper'

RSpec.describe RepresentativesController, type: :controller do
  describe 'GET #show' do
    it 'renders the show template' do
      representative_instance = double(
        'Representative', 
        id: 1,
        name: 'John Doe',
        ocdid: '1',
        title: 'Rep title',
        street: 'Rep street', # New attribute
        city: 'Rep city',
        state: 'Rep state',
        zip: 94704,
        party: 'Rep party',
        photo: 'https://a1cf74336522e87f135f-2f21ace9a6cf0052456644b80fa06d4f.ssl.cf2.rackcdn.com/images/characters/large/2800/Joey-Tribbiani.Friends.webp'
      )
      get :show, params: { id: representative_instance.id }
      expect(response).to render_template(:show)
    end
  end
end
