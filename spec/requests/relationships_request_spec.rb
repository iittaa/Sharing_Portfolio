require 'rails_helper'

RSpec.describe 'Relationships', type: :request do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  # let(:rela) { create(:relationship, following_id: user.id, follower_id: other_user.id) }

  describe 'create' do
    before { sign_in user }
    it '正常にフォローできること' do
      expect do
        post relationships_path(follower_id: user.id, following_id: other_user.id), xhr: true
      end.to change(Relationship, :count).by(1)
    end
  end

  # describe 'destroy' do
  #     before { sign_in user }
  #   it '正常にフォローの解除ができること' do
  #     expect do
  #       delete relationship_path(id: rela.id), xhr: true
  #     end.to change(Relationship, :count).by(-1)
  #   end
  # end
end
