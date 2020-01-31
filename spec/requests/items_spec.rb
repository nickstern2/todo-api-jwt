require 'rails_helper'

RSpec.describe 'Items API' do
  let(:user) { create(:user) }
  let!(:todo) { create(:todo, created_by: user.id) }
  let!(:items) { create_list(:item, 20, todo_id: todo.id) }
  let(:todo_id) { todo.id }
  let(:id) { items.first.id }
  let(:headers) { valid_headers }

  # Test suite for GET /todos/:todo_id/items
  describe 'GET /todos/:todo_id/items' do
    before { get "/todos/#{todo_id}/items", params: {}, headers: headers }

    context 'when todo exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all todo items' do
        expect(json.size).to eq(20)
      end
    end

    context 'when todo does not exist' do
      let(:todo_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Todo/)
      end
    end
  # Get test suite for ALL Items of one Todos
  end

  # Test suite for GET /todos/:todo_id/items/:id
  describe 'GET /todos/:todo_id/items/:id' do
     before { get "/todos/#{todo_id}/items/#{id}", params: {}, headers: headers }

    context 'when todo item exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the items' do
        expect(json['id']).to eq(id)
      end
    end

    context "when todo doesn't exist" do
      let(:id) { 0 }

      it 'return status code 404' do
        expect(response).to have_http_status(404)
      end
      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Item/)
      end
    end
  # Get test suite for ONE Item of one Todo
  end


  # Test suite for PUT /todos/:todo_id/items
  describe 'PUT /todos/:todo_id/items' do
    let(:valid_attributes) { { name: 'Visit Narnia', done: false }.to_json }

    context 'when request attributes are valid' do
      before do
        post "/todos/#{todo_id}/items", params: valid_attributes, headers: headers
      end
    end

    context 'when an invalid request' do
      before { post "/todos/#{todo_id}/items", params: {}, headers: headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Name can't be blank/)
      end
    end
  end

  # Test suite for PUT /todos/:todo_id/items/:id
  describe 'PUT /todos/:todo_id/items/:id' do
    let(:valid_attributes) { { name: 'Mozart' }.to_json }

    before do
      put "/todos/#{todo_id}/items/#{id}", params: valid_attributes, headers: headers
    end

    context 'When item exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the item' do
        updated_item = Item.find(id)
        expect(updated_item.name).to match(/Mozart/)
      end
    end

    context 'When item does not exist' do
      let(:id) { 0 }

      it 'should return status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Item/)
      end
    end

  # Put Test suite
  end

  # suite for DELETE /todos/:id
  describe 'DELETE /todos/:id' do
    before { delete "/todos/#{todo_id}/items/#{id}", params: {}, headers: headers }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
# RSpec end
end
