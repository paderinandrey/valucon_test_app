require 'rails_helper'

RSpec.describe PhotosController, type: :controller do
  describe 'GET #index' do
    let!(:photos) { create_list(:photo, 2) }

    before { get :index }

    it 'populates an array of all photos' do
      expect(assigns(:photos)).to match_array(photos)
    end

    it 'renders index view' do
      expect(response).to render_template :index
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'saves the new photo in the database' do
        expect { post :create, params: { photo: attributes_for(:photo) } }.to change(Photo, :count).by(1)
      end

      it 'reload index view' do
        post :create, params: { photo: attributes_for(:photo) }
        expect(response).to redirect_to photos_path
      end
    end
  end
end
