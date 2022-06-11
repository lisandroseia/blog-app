require 'rails_helper'

RSpec.describe 'users render correct template', type: :request do
  context 'Get *index' do
    before :each do
      get '/users/1'
    end
    it 'runs template' do
      expect(response).to render_template('users/show')
    end

    it 'gives correct response' do
      expect(response).to have_http_status(:ok)
    end

    it 'gives correct body' do
      expect(response.body).to include('Joey')
    end
  end
  context 'Get #index' do
    before :each do
      get '/users'
    end
    it 'runs template' do
      expect(response).to render_template('users/index')
    end

    it 'gives correct response' do
      expect(response).to have_http_status(:ok)
    end

    it 'gives correct body' do
      expect(response.body).to include('Joey')
    end
  end
end
