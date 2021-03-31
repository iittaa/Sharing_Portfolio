require 'rails_helper'

RSpec.describe Notification, type: :model do
  describe '各モデルとのアソシエーション' do
    let(:association) do
      described_class.reflect_on_association(target)
    end

    context 'postモデルとのアソシエーション' do
      let(:target) { :post }
      it 'postモデルとの関係はbelongs_toであること' do
        expect(association.macro).to eq :belongs_to
      end
    end

    context 'commentモデルとのアソシエーション' do
      let(:target) { :comment }
      it 'commentモデルとの関係はbelongs_toであること' do
        expect(association.macro).to eq :belongs_to
      end
    end

    context '仮想モデルvisitorとのアソシエーション' do
      let(:target) { :visitor }
      it '仮想モデルvisitorとの関係はbelongs_toであること' do
        expect(association.macro).to eq :belongs_to
      end
    end

    context '仮想モデルvisitedとのアソシエーション' do
      let(:target) { :visited }
      it '仮想モデルvisitedとの関係はbelongs_toであること' do
        expect(association.macro).to eq :belongs_to
      end
    end
  end
end
