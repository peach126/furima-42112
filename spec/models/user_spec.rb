require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    it 'nicknameが空では登録できない' do
      @user.nickname = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Nickname can't be blank")
    end
    it 'emailが空では登録できない' do
      @user.email = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end
    it '重複したemailが存在する場合は登録できない' do
      @user.save
      @another_user = FactoryBot.build(:user)
      @another_user.email = @user.email
      @another_user.valid?
      expect(@another_user.errors.full_messages).to include('Email has already been taken')
    end
    it 'emailは@を含まないと登録できない' do
      @user.email = 'testmail'
      @user.valid?
      expect(@user.errors.full_messages).to include('Email is invalid')
    end
    it 'passwordが空では登録できない' do
      @user.password = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end
    it 'passwordが5文字以下では登録できない' do
      @user.password = '00000'
      @user.password_confirmation = '00000'
      @user.valid?
      expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
    end
    it 'passwordが半角英数字混合であれば登録できる' do
      @user.password = '123abc'
      @user.password_confirmation = '123abc'
      expect(@user).to be_valid
    end
    it 'passwordとpassword_confirmationが不一致では登録できない' do
      @user.password = '123456'
      @user.password_confirmation = '1234567'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end
    it '名字が全角（漢字・ひらがな・カタカナ）であれば登録できる' do
      @user.family_name = '山田'
      expect(@user).to be_valid
    end
    it '名前が全角（漢字・ひらがな・カタカナ）であれば登録できる' do
      @user.first_name = '陸太郎'
      expect(@user).to be_valid
    end
    it '名字のフリガナが全角（カタカナ）であれば登録できる' do
      @user.family_name_kana = 'ヤマダ'
      expect(@user).to be_valid
    end
    it '名前のフリガナが全角（カタカナ）であれば登録できる' do
      @user.first_name_kana = 'リクタロウ'
      expect(@user).to be_valid
    end
    it '生年月日が空欄だと保存できない' do
      @user.birthday = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Birthday can't be blank")
    end
  end
end
