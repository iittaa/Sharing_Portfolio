require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe "ユーザーの新規登録" do
    context "ユーザーの新規登録が成功する時" do
      it "名前、メールアドレス、パスワードがある場合有効である" do
        expect(@user).to be_valid
      end

      it "画像"

    end
    

    it "名前がない場合無効である"
    it "名前の文字数が100文字以内の場合、有効である"
    it "メールアドレスがない場合無効である"
    it "重複したメールアドレスの場合、無効である"
    it "パスワードがない場合無効である"
  end

  describe "異常系" do
  end 

  
  
  before do 
    @user = build(:user)
  end

  describe 'バリデーション' do

    it 'nameが空だとNG' do
      @user.name = ''
      expect(@user.valid?).to eq(false)
    end
  end
end