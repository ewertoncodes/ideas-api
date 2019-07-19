require 'rails_helper'

RSpec.describe 'Idea API' do
  let!(:ideas){ create_list(:idea, 5) }
  let(:idea_id) { ideas.first.id }

  describe 'GET /api/v1/ideas' do
    it 'returns status ok' do
      get '/api/v1/ideas'
      
      expect(response).to have_http_status(:ok)
    end
    
    it 'returns all ideas' do
      get '/api/v1/ideas'
      
      expect(JSON.parse(response.body).size).to eq(5)
    end
  end

  describe 'POST /api/v1/ideas' do
    context 'when attributes are valid' do
      it 'returns status ok' do
        post '/api/v1/ideas', params: { idea: { title:"first idea", body: "make a blog" } }
        
        expect(response).to have_http_status(:created)
      end
      
      it 'returns all ideas' do      
        expect{
          post '/api/v1/ideas', params: { idea: { title:"first idea", body: "make a blog" } }
      }.to change(Idea,:count).by(1)
      end      
    end

    context 'when attributes are valid' do
      it 'returns status ok' do
        post '/api/v1/ideas', params: { idea: { title:"first idea", body: nil } }
        
        expect(response).to have_http_status(:unprocessable_entity)
      end
      
      it 'returns all ideas' do      
        expect{
          post '/api/v1/ideas', params: { idea: { title:"first idea", body: nil } }
      }.to_not change(Idea,:count)
      end      
    end
  end

  describe 'PUT api/v1/ideas/:id' do
    let(:idea){ create(:idea) }
    let(:idea_id) { idea.id }

    it 'returns status no_content' do
      put "/api/v1/ideas/#{idea_id}", params: { idea: { title:"my first ideia", body: "make a blog" }}
      
      expect(response).to have_http_status(:no_content)
    end

    it 'updates the attributes' do
      put "/api/v1/ideas/#{idea_id}", params: { idea: { title:"my first ideia", body: "build a gem" }}
      
      idea.reload
      
      expect(idea.body).to eq('build a gem')
    end
  end


  describe 'PATCH api/v1/ideas/:id' do
    let(:idea){ create(:idea) }
    let(:idea_id) { idea.id }

    it 'returns status no_content' do
      patch "/api/v1/ideas/#{idea_id}", params: { idea: { title:"my first ideia", body: "make a blog" }}
      
      expect(response).to have_http_status(:no_content)
    end

    it 'updates the attributes' do
      patch "/api/v1/ideas/#{idea_id}", params: { idea: { title:"my first ideia", body: "build a gem" }}
      
      idea.reload
      
      expect(idea.body).to eq('build a gem')
    end
  end

  describe 'DELETE api/v1/ideas/:id' do
    it 'returns status no_content' do
      delete "/api/v1/ideas/#{idea_id}"
      
      expect(response).to have_http_status(:no_content)
    end

    it 'remove the ideia' do
      expect{ 
        delete "/api/v1/ideas/#{idea_id}"
      }.to change(Idea, :count).by(-1)
    end
  end
end