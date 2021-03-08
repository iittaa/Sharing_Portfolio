require 'rails_helper'

RSpec.describe 'Notifications', type: :request do
  let(:user) { create(:user) }
  describe 'index' do
    context 'ログインしている場合' do
      before { sign_in user }
      it 'リクエストが成功すること' do
        get notifications_url
        expect(response.status).to eq 200
      end
    end

    context 'ログインしていない場合' do
      it 'ログイン画面にリダイレクトされること' do
        get notifications_url
        expect(response).to redirect_to new_user_session_url
      end
    end
  end
end
