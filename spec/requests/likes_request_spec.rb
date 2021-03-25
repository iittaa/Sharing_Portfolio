require 'rails_helper'

RSpec.describe "Likes", type: :request do
  let(:user) { create(:user) }

  let(:like_post) { create(:post, user: user) }

  describe 'create' do
    before { sign_in user }
    it '正常にいいねできること' do
      expect do
        post "/posts/#{like_post.id}/likes", xhr: true
      end.to change(Like, :count).by(1)
    end
  end

  describe 'destroy' do
    before {
      sign_in user
      @like = create(:like, user_id: user.id, post_id: like_post.id)
    }
    it '正常にいいねの解除ができること' do
      expect do
        delete "/posts/#{like_post.id}/likes", xhr: true
      end.to change(Like, :count).by(-1)
    end
  end
end
