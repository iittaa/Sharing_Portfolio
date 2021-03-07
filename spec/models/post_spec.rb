require 'rails_helper'

RSpec.describe Post, type: :model do
  before do
    @post = create(:post)
  end

  describe "作品を投稿する" do
    context "作品が投稿できる場合" do
      it "正しく投稿できる" do
        @post.valid?
        expect(@post).to be_valid
      end

      it "nameが50文字以内の場合、投稿できない" do
        @post.name = "a" * 50
        @post.valid?
        expect(@post).to be_valid
      end

      it "contentが500文字以内の場合、投稿できない" do
        @post.content = "a" * 500
        @post.valid?
        expect(@post).to be_valid
      end

      it "imageが空白の場合でも、投稿できる" do
        @post.image = ""
        @post.valid?
        expect(@post).to be_valid
      end

      it "pointが空白の場合でも、投稿できる" do
        @post.point = ""
        @post.valid?
        expect(@post).to be_valid
      end

      it "pointが500文字以内の場合、投稿できない" do
        @post.point = "a" * 500
        @post.valid?
        expect(@post).to be_valid
      end
    end

    context "作品が投稿できない場合" do
      it "nameが空白の場合、投稿できない" do
        @post.name = ""
        @post.valid?
        expect(@post.errors[:name]).to include("を入力してください")
      end

      it "nameが50文字より多い場合、投稿できない" do
        @post.name = "a" * 51
        @post.valid?
        expect(@post.errors[:name]).to include("は50文字以内で入力してください")
      end

      it "contentが空白の場合、投稿できない" do
        @post.content = ""
        @post.valid?
        expect(@post.errors[:content]).to include("を入力してください")
      end

      it "contentが500文字より多い場合、投稿できない" do
        @post.content = "a" * 501
        @post.valid?
        expect(@post.errors[:content]).to include("は500文字以内で入力してください")
      end

      it "urlが空白の場合、投稿できない" do
        @post.url = ""
        @post.valid?
        expect(@post.errors[:url]).to include("を入力してください")
      end

      it "periodが空白の場合、投稿できない" do
        @post.period = ""
        @post.valid?
        expect(@post.errors[:period]).to include("を入力してください")
      end

      it "pointが500文字より多い場合、投稿できない" do
        @post.point = "a" * 501
        @post.valid?
        expect(@post.errors[:point]).to include("は500文字以内で入力してください")
      end

      it "user_idが空白の場合、投稿できない" do
        @post.user_id = nil
        @post.valid?
        expect(@post.errors[:user]).to include("を入力してください")
      end
    end
  end


  describe "各モデルとのアソシエーション" do
    let(:association) do
      # reflect_on_associationで対象のクラスと引数で指定するクラスのアソシエーションを返す
      described_class.reflect_on_association(target)
    end

    context "stockモデルとのアソシエーション" do
      let(:target) { :stocks }
      it "stockモデルとの関係はhas_manyであること" do
        # macroメソッドで関連付けを返す
        expect(association.macro).to eq :has_many
      end

      it "postが削除されたら、stockも削除されること" do
        @stock = create(:stock, post_id: @post.id)
        expect{ @post.destroy }.to change(Stock, :count).by(-1)
      end
    end

    context "commentモデルとのアソシエーション" do
      let(:target) { :comments }
      it "commentモデルとの関係はhas_manyであること" do
        expect(association.macro).to eq :has_many
      end

      it "postが削除されたら、commentも削除されること" do
        @comment = create(:comment, post_id: @post.id)
        expect{ @post.destroy }.to change(Comment, :count).by(-1)
      end
    end

    context "notificationsモデルとのアソシエーション" do
      let(:target) { :notifications }
      it "notificationsモデルとの関係はhas_manyであること" do
        expect(association.macro).to eq :has_many
      end

      it "postが削除されたら、notificationsも削除されること" do
        @notification = create(:notification, post_id: @post.id)
        expect{ @post.destroy }.to change(Notification, :count).by(-1)
      end
    end
  end
end