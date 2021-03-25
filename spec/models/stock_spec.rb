require 'rails_helper'

RSpec.describe Stock, type: :model do
  let(:stock) { create(:stock) }

  describe 'ストックをする' do
    context 'ストックが保存できる場合' do
      it 'user_idとpost_idが存在する場合、保存できる' do
        stock.valid?
        expect(stock).to be_valid
      end

      it 'user_idが同じでもpost_idが違う場合、保存できる' do
        expect(create(:stock, user_id: stock.user_id)).to be_valid
      end

      it 'post_idが同じでもuser_idが違う場合、保存できる' do
        expect(create(:stock, post_id: stock.post_id)).to be_valid
      end
    end

    context 'ストックが保存できない場合' do
      it 'user_idが空白の場合、保存できない' do
        stock.user_id = nil
        stock.valid?
        expect(stock).to be_invalid
      end

      it 'post_idが空白の場合、保存できない' do
        stock.post_id = nil
        stock.valid?
        expect(stock).to be_invalid
      end

      it 'user_idとpost_idの組み合わせが重複した場合、保存できない' do
        @other_stock = build(:stock, user_id: stock.user_id, post_id: stock.post_id)
        @other_stock.valid?
        expect(@other_stock).to be_invalid
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
