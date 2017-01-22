require 'rails_helper'

RSpec.describe FeedbacksController, type: :controller do
  describe 'GET /index' do
    let!(:feedbacks) { create_list(:feedback, 3) }
    let(:feedback) { feedbacks.first }

    before { get :index, params: { format: :json } }

    it 'returns 200 status code' do
      expect(response).to be_success
    end

    it 'returns list of feedbacks' do
      expect(response.body).to have_json_size(3)
    end

    %w(id email text).each do |attr|
      it "Feedback object contains #{attr}" do
        expect(response.body).to be_json_eql(feedback.send(attr.to_sym).to_json).at_path("0/#{attr}")
      end
    end
  end

  describe 'POST /create' do
    context 'with valid attributes' do
      it 'saves the new feedback in the database' do
        expect { post :create, params: { feedback: attributes_for(:feedback), format: :json } }.to change(Feedback, :count).by(1)
      end

      it 'return feedback' do
        post :create, params: { feedback: attributes_for(:feedback), format: :json }
        %w(id email text).each do |attr|
          expect(response.body).to be_json_eql(Feedback.last.send(attr.to_sym).to_json).at_path(attr)
        end
      end
    end

    context 'with invalid attributes' do
      it 'does not save the feedback' do
        expect { post :create, params: { feedback: attributes_for(:invalid_feedback), format: :json } }.to_not change(Feedback, :count)
      end

      it 'returns empty feedback' do
        post :create, params: { feedback: attributes_for(:invalid_feedback), format: :json }
        expect(response.body).to be_json_eql(attributes_for(:invalid_feedback).to_json)
      end
    end
  end
end
