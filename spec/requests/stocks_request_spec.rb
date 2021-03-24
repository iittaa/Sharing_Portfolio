require 'rails_helper'

RSpec.describe 'Stocks', type: :request do
  let(:user) { create(:user) }

  let(:stock_post) { create(:post, user: user) }

  describe 'create' do
    before { sign_in user }
    it '正常にいいねできること' do
      expect do
        post "/posts/#{stock_post.id}/stocks", xhr: true
      end.to change(Stock, :count).by(1)
    end
  end

  describe 'destroy' do
    before do
      sign_in user
      stock = create(:stock, user_id: user.id, post_id: stock_post.id)
    end
    it '正常にいいねの解除ができること' do
      expect do
        delete "/posts/#{stock_post.id}/stocks", xhr: true
      end.to change(Stock, :count).by(-1)
    end
  end

  # describe 'index' do
  #   context 'ログインしている場合' do
  #     before { sign_in user }
  #     it 'リクエストが成功すること' do
  #       get stocks_url
  #       expect(response.status).to eq 200
  #     end
  #   end

  #   context 'ログインしていない場合' do
  #     it 'ログイン画面にリダイレクトされること' do
  #       get stocks_url
  #       expect(response).to redirect_to new_user_session_url
  #     end
  #   end
  # end
end
