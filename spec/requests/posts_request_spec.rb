require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  let(:user) { create(:user) }
  let!(:other_user) { create(:user) }

  let!(:post1) { create(:post, user: user) }
  let(:post_params) do
    {
      name: 'name',
      content: 'content',
      period: 'period',
      url: 'https://www.test.com/',
      point: 'point',
      tag_ids: 'tag'
    }
  end

  describe 'index' do
    context 'ログインしている場合' do
      before { sign_in user }
      it 'リクエストが成功すること' do
        get posts_url
        expect(response.status).to eq 200
      end
    end

    context 'ログインしていない場合' do
      it 'ログイン画面にリダイレクトされること' do
        get posts_url
        expect(response).to redirect_to new_user_session_url
      end
    end
  end

  describe 'show' do
    context 'ログインしている場合' do
      before { sign_in user }
      it 'リクエストが成功すること' do
        get post_url(post1)
        expect(response.status).to eq 200
      end
    end

    context 'ログインしていない場合' do
      it 'ログイン画面にリダイレクトされること' do
        get post_url(post1)
        expect(response).to redirect_to new_user_session_url
      end
    end
  end

  describe 'new' do
    context 'ログインしている場合' do
      before { sign_in user }
      it 'リクエストが成功すること' do
        get new_post_url
        expect(response.status).to eq 200
      end
    end

    context 'ログインしていない場合' do
      it 'ログイン画面にリダイレクトされること' do
        get new_post_url
        expect(response).to redirect_to new_user_session_url
      end
    end
  end

  describe 'create' do
    context 'ログインしている場合' do
      before { sign_in user }
      it '正常に投稿が保存できること' do
        expect { post posts_url, params: { post: post_params } }.to change(Post, :count).by(1)
      end
    end

    context 'ログインしていない場合' do
      it 'ログイン画面にリダイレクトされること' do
        get new_post_url
        expect(response).to redirect_to new_user_session_url
      end
    end
  end

  describe 'edit' do
    context 'ログインしている場合' do
      context '本人の場合' do
        before { sign_in user }
        it 'リクエストが成功すること' do
          get edit_post_url(post1)
          expect(response.status).to eq 200
        end
      end

      context '本人以外の場合' do
        before { sign_in other_user }
        it 'リダイレクトされること' do
          get edit_post_url(post1)
          expect(response).to redirect_to root_url
        end
      end
    end

    context 'ログインしていない場合' do
      it 'ログイン画面にリダイレクトされること' do
        get edit_post_url(post1)
        expect(response).to redirect_to new_user_session_url
      end
    end
  end

  describe 'destroy' do
    context 'ログインしている場合' do
      context '本人の場合' do
        before { sign_in user }
        it '正常に削除されること' do
          expect { delete post_url(post1) }.to change(Post, :count).by(-1)
          expect(response).to redirect_to root_url
        end
      end

      context '本人以外の場合' do
        before { sign_in other_user }
        it '削除されないこと' do
          expect { delete post_url(post1) }.not_to change(Post, :count)
          expect(response).to redirect_to root_url
        end
      end
    end

    context 'ログインしていない場合' do
      it 'ログイン画面にリダイレクトされること' do
        delete post_url(post1)
        expect(response).to redirect_to new_user_session_url
      end
    end
  end
end
