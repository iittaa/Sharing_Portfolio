require 'rails_helper'

RSpec.describe 'Users', type: :request do
  let(:user) { create(:user) }
  let!(:other_user) { create(:user) }

  describe 'show' do
    context 'ログインしている場合' do
      before { sign_in user }
      it 'リクエストが成功すること' do
        get user_url(user)
        expect(response.status).to eq 200
      end
    end

    context 'ログインしていない場合' do
      it 'ログイン画面にリダイレクトされること' do
        get user_url(user)
        expect(response.status).to redirect_to new_user_session_url
      end
    end
  end

  describe 'edit' do
    context 'ログインしている場合' do
      before { sign_in user }
      it 'リクエストが成功すること' do
        get edit_user_registration_url
        expect(response.status).to eq 200
      end
    end

    context 'ログインしていない場合' do
      it 'ログイン画面にリダイレクトされること' do
        get edit_user_registration_url
        expect(response).to redirect_to new_user_session_url
      end
    end
  end

  describe 'destroy' do
    context 'ログインしている場合' do
      before { sign_in user }
      context '本人の場合' do
        it '正常に削除されること' do
          expect { delete user_url(user) }.to change(User, :count).by(-1)
          expect(response).to redirect_to root_url
        end
      end

      context '本人以外の場合' do
        it '削除されないこと' do
          expect { delete user_url(other_user) }.not_to change(User, :count)
          expect(response).to redirect_to root_url
        end
      end
    end

    context 'ログインしていない場合' do
      it 'ログイン画面にリダイレクトされること' do
        delete user_url(user)
        expect(response).to redirect_to new_user_session_url
      end
    end
  end
end
