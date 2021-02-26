require 'rails_helper'

RSpec.describe User, type: :model do
  # バリデーション

  
    it "名前がない場合無効である"
    it "重複した"
    it "名前がない場合無効である"
    it "名前がない場合無効である"
    it "名前がない場合無効である"
    it "名前がない場合無効である"

  
  
  
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