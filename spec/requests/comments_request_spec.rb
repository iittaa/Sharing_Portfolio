require 'rails_helper'

RSpec.describe 'Comments', type: :request do
  let(:user) { create(:user) }

  let(:comment_post) { create(:post, user: user) }
  let(:comment_params) do
    {
      content: 'content',
      user_id: user.id,
      post_id: comment_post.id
    }
  end

  describe 'create' do
    before { sign_in user }
    it '正常にコメントできること' do
      expect do
        post post_comments_url(comment_post.id), params: { comment: comment_params }, xhr: true
      end.to change(Comment, :count).by(1)
    end
  end

  describe 'destroy' do
    before { sign_in user }
    it '正常にコメントを削除できること' do
      comment = create(:comment, content: 'content', user_id: user.id, post_id: comment_post.id)
      expect do
        delete post_comment_url(comment_post.id, comment.id), xhr: true
      end.to change(Comment, :count).by(-1)
    end
  end
end
