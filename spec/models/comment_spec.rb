require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:comment) { create(:comment) }

  describe 'コメントをする' do
    context 'コメントが保存できる場合' do
      it 'user_id,post_id,contentが存在する場合、保存できる' do
        comment.valid?
        expect(comment).to be_valid
      end

      it 'contentが1文字以上の場合、保存できる' do
        comment.content = 'a' * 1
        comment.valid?
        expect(comment).to be_valid
      end

      it 'contentが500文字以内の場合、保存できる' do
        comment.content = 'a' * 500
        comment.valid?
        expect(comment).to be_valid
      end
    end

    context 'コメントが保存できない場合' do
      it 'user_idが空白の場合、保存できない' do
        comment.user_id = nil
        comment.valid?
        expect(comment).to be_invalid
      end

      it 'post_idが空白の場合、保存できない' do
        comment.post_id = nil
        comment.valid?
        expect(comment).to be_invalid
      end

      it 'contentが空白の場合、保存できない' do
        comment.content = ''
        comment.valid?
        expect(comment).to be_invalid
      end

      it 'contentが501文字以上の場合、保存できない' do
        comment.content = 'a' * 501
        comment.valid?
        expect(comment).to be_invalid
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

    context 'notificationモデルとのアソシエーション' do
      let(:target) { :notifications }
      it 'notificationモデルとの関係はhas_manyであること' do
        expect(association.macro).to eq :has_many
      end

      it 'commentが削除されたら、notificationも削除されること' do
        @notification = create(:notification, comment_id: comment.id)
        expect { comment.destroy }.to change(Notification, :count).by(-1)
      end
    end
  end
end
