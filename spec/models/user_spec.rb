require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe "ユーザー登録" do
    context "ユーザーが保存される場合" do
      it "name, email, passwordが存在すれば登録できる" do
        @user.valid?
        expect(@user).to be_valid
      end

      it "nameが50文字以下の場合、登録できる" do
        @user.name = "a" * 50
        @user.valid?
        expect(@user).to be_valid
      end

      it "passwordが6文字以上の場合、登録できる" do
        @user.password = "a" * 6
        @user.password_confirmation = "a" * 6
        @user.valid?
        expect(@user).to be_valid
      end

      it "メールアドレスが正常なフォーマットの場合、登録できる" do
        addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
        addresses.each do |valid_address|
          @user.email = valid_address
          expect(@user).to be_valid
        end
      end
      
    end

    context "ユーザーが保存されない場合" do
      it "nameが空白の場合、登録に失敗する" do
        @user.name = ""
        @user.valid?
        expect(@user.errors[:name]).to include("を入力してください")
      end

      it "nameが50文字より多い場合、登録に失敗する" do
        @user.name = "a" * 51
        @user.valid?
        expect(@user.errors[:name]).to include("は50文字以内で入力してください")
      end

      it "emailが空白の場合、登録に失敗する" do
        @user.email = ""
        @user.valid?
        expect(@user.errors[:email]).to include("を入力してください")
      end

      it "emailが重複している場合、登録に失敗する" do
        @user = FactoryBot.create(:user)
        @other_user = FactoryBot.build(:user, email: @user.email)
        @other_user.valid?
        expect(@other_user.errors[:email]).to include("はすでに存在します")
      end

      it "passwordが空白の場合、登録に失敗する" do
        @user.password = ""
        @user.valid?
        expect(@user.errors[:password]).to include("を入力してください")
      end

      it "passwordが6文字未満の場合、登録に失敗する" do
        @user.password = "a" * 5
        @user.valid?
        expect(@user.errors[:password]).to include("は6文字以上で入力してください")
      end

      it "password_confirmationが空白の場合、登録に失敗する" do
        @user.password_confirmation = ""
        @user.valid?
        expect(@user.errors[:password_confirmation]).to include("とパスワードの入力が一致しません")
      end

      it "passwordとpassword_confirmationが不一致の場合、登録に失敗する" do
        @user.password = "password"
        @user.password_confirmation = "passwor"
        @user.valid?
        expect(@user.errors[:password_confirmation]).to include("とパスワードの入力が一致しません")
      end

      it "パスワードが暗号化されていること" do
        @user.password = "password"
        expect(@user.encrypted_password).to_not eq "password"
      end

    end
  end
end