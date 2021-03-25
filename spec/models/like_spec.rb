require 'rails_helper'

RSpec.describe Like, type: :model do
  let(:like) { create(:like) }

  describe 'いいねをする' do
    context 'いいねが保存できる場合' do
      it 'user_idとpost_idが存在する場合、保存できる' do
        like.valid?
        expect(like).to be_valid
      end

      it 'user_id同じでもpost_idが違う場合、保存できる' do
        expect(create(:like, user_id: like.user_id)).to be_valid
      end

      it 'post_id同じでもuser_idが違う場合、保存できる' do
        expect(create(:like, post_id: like.post_id)).to be_valid
      end
    end

    context 'いいねが保存できない場合' do
      it 'user_idが空白の場合、保存できない' do
        like.user_id = nil
        like.valid?
        expect(like).to be_invalid
      end

      it 'post_idが空白の場合、保存できない' do
        like.post_id = nil
        like.valid?
        expect(like).to be_invalid
      end

      it 'user_idとpost_idの組み合わせが重複した場合、保存できない' do
        @other_like = build(:like, user_id: like.user_id, post_id: like.post_id)
        @other_like.valid?
        expect(@other_like).to be_invalid
      end
    end
  end

  describe '各モデルとのアソシエーション' do
    let(:association) do
      described_class.reflect_on_association(target)
    end

    context 'userモデルとのアソシエーション' do
      let(:target) { :user }
      it 'userモデルとの関係はbelongs_toであること' do
        expect(association.macro).to eq :belongs_to
      end
    end

    context 'postモデルとのアソシエーション' do
      let(:target) { :post }
      it 'postモデルとの関係はbelongs_toであること' do
        expect(association.macro).to eq :belongs_to
      end
    end
  end
end
