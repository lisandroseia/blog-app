require_relative '../rails_helper'

RSpec.describe 'posts render correct template', type: :request do
  context 'Get #index posts' do
    before :each do
      get '/users/1/posts'
    end
    it 'runs template' do
      expect(response).to render_template('posts/index')
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
      get '/users/1/posts/1'
    end
    it 'runs template' do
      expect(response).to render_template('posts/show')
    end

    it 'gives correct response' do
      expect(response).to have_http_status(:ok)
    end

    it 'gives correct body' do
      expect(response.body).to include('Food')
    end
  end
end
