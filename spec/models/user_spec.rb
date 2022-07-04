require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できる場合' do
      it "全ての項目が正しければ登録ができる" do
        expect(@user).to be_valid
      end
    end
    context '新規登録できない場合' do
      it "nicknameが空では登録できない" do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it "emailが空では登録できない" do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it "passwordが空では登録できない" do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it "passwordが数字のみでは登録できない" do
        @user.password = '123456'
        @user.password_confirmation = "123456"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password 文字と数字の両方を含めて入力してください")
      end
      it "passwordは全角英字混合では保存できない" do
        @user.password = '１２３ａｂｃ'
        @user.password_confirmation = "１２３ａｂｃ"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password 文字と数字の両方を含めて入力してください")
      end
      it "passwordがアルファベットのみでは登録できない" do
        @user.password = 'abcdef'
        @user.password_confirmation = "abcdef"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password 文字と数字の両方を含めて入力してください")
      end
      it 'passwordが5文字以下では登録できない' do
        @user.password = '12345'
        @user.password_confirmation = '12345'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end
      it 'passwordが129文字以上では登録できない' do
        @user.password =  Faker::Internet.password(min_length: 129)
        @user.password_confirmation =  @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too long (maximum is 128 characters)')
      end
      it 'passwordとpassword_confirmationが不一致では登録できない' do
        @user.password = '123456'
        @user.password_confirmation = '1234567'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it '重複したemailが存在する場合は登録できない' do
        @user.save
        another_user = FactoryBot.build(:user, email: @user.email)
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end
      it 'emailは@を含まないと登録できない' do
        @user.email = 'testmail'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end
      it "first_name_kanjiが空では登録できない" do
        @user.first_name_kanji = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kanji can't be blank") 
      end

      it "last_name_kanjiが空では登録できない" do
        @user.last_name_kanji = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kanji can't be blank") 
      end

      it "first_name_kanjiが全角（漢字・ひらがな・カタカナ）での入力でなければ登録できない" do
        @user.first_name_kanji = "aaa"
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kanji は全角でご入力ください") 
      end

      it "last_name_kanjiが全角（漢字・ひらがな・カタカナ）での入力でなければ登録できない" do
        @user.last_name_kanji = "aaa"
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kanji は全角でご入力ください")
      end

      it "first_name_kanaが空では登録できない" do
        @user.first_name_kana = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana can't be blank")
      end
     
      it "last_name_kanaが空では登録できない" do
        @user.last_name_kana = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana can't be blank") 
      end
      it "first_name_kanaが全角（カタカナ）での入力でなければ登録できない" do
        @user.first_name_kana = "aaa"
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana はカタカナでご入力ください")
      end
     
      it "last_name_kanaが全角（カタカナ）での入力でなければ登録できない" do
        @user.last_name_kana = "aaa"
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana はカタカナでご入力ください") 
      end

      it "birthdayが空では登録できない" do
        @user.birthday = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday can't be blank") 
      end
    end
  end
end