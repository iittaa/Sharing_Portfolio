require 'rails_helper'

RSpec.describe Relationship, type: :model do
  let(:relationship) { create(:relationship) }

  describe 'フォローする' do
    context '保存できる場合' do
      it 'follower_idとfollowing_idが存在する場合、保存できる' do
        relationship.valid?
        expect(relationship).to be_valid
      end

      it 'follower_idが同じでもfollowing_idが違う場合、保存できる' do
        expect(create(:relationship, follower_id: relationship.follower_id)).to be_valid
      end

      it 'following_idが同じでもfollower_idが違う場合、保存できる' do
        expect(create(:relationship, following_id: relationship.following_id)).to be_valid
      end
    end

    context '保存できない場合' do
      it 'follower_idが空白の場合、保存できない' do
        relationship.follower_id = nil
        relationship.valid?
        expect(relationship).to be_invalid
      end

      it 'following_idが空白の場合、保存できない' do
        relationship.following_id = nil
        relationship.valid?
        expect(relationship).to be_invalid
      end

      it 'follower_idとfollowing_idの組み合わせが重複した場合、保存できない' do
        @other_rela = build(:relationship, follower_id: relationship.follower_id, following_id: relationship.following_id)
        @other_rela.valid?
        expect(@other_rela).to be_invalid
      end
    end
  end

  describe '各モデルとのアソシエーション' do
    let(:association) do
      described_class.reflect_on_association(target)
    end

    context '仮想モデルfollowerとのアソシエーション' do
      let(:target) { :follower }
      it '仮想モデルfollowerとの関係はbelongs_toであること' do
        expect(association.macro).to eq :belongs_to
      end
    end

    context '仮想モデルfollowingとのアソシエーション' do
      let(:target) { :following }
      it '仮想モデルfollowingとの関係はbelongs_toであること' do
        expect(association.macro).to eq :belongs_to
      end
    end
  end
end
