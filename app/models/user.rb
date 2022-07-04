class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  VALID_PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i.freeze
  zenkaku = /\A[ぁ-んァ-ヶ一-龥々ー]+\z/
  katakana = /\A[ァ-ヶー－]+\z/

 validates :password, format: {with: VALID_PASSWORD_REGEX, message: '文字と数字の両方を含めて入力してください' }, allow_blank: true
 validates :nickname, presence: true
 validates :first_name_kanji, presence: true
 validates :first_name_kanji, format: {with: zenkaku, message: 'は全角でご入力ください'}, allow_blank:true

 validates :last_name_kanji, presence: true
 validates :last_name_kanji, format:  {with: zenkaku, message: 'は全角でご入力ください'}, allow_blank: true
 validates :first_name_kana, presence: true
 validates :first_name_kana, format: {with: katakana, message: 'はカタカナでご入力ください'}, allow_blank:true
 validates :last_name_kana, presence: true
 validates :last_name_kana, format: {with: katakana, message: 'はカタカナでご入力ください'}, allow_blank:true

 validates :birthday, presence: true


 has_many :items 
 #has_many :purchases
end




