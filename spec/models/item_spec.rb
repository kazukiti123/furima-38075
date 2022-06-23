require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品出品機能' do
    context '商品の出品ができる場合' do
      it "全ての項目が正しく入力された場合登録ができる" do
        expect(@item).to be_valid
      end
    end
    context '商品の出品ができない場合' do
      it "imageが空では登録できない" do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end
      it "商品名が空では登録できない" do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Name can't be blank")
      end
      it "explanationが空では登録できない" do
        @item.explanation = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Explanation can't be blank")
      end
      it "category_idが---の場合は登録できない" do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Category can't be blank")
      end
      it "states_idが---の場合は登録できない" do
        @item.states_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("States can't be blank")
      end
      it "postage_idが---の場合は登録できない" do
        @item.postage_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Postage can't be blank")
      end
      it 'prefecture_idが---の場合は登録できない' do
        @item.prefecture_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture can't be blank")
      end
      it 'send_time_idが---の場合は登録できない' do
        @item.send_time_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Send time can't be blank")
      end
      it 'priceが空の場合は登録できない' do
        @item.price = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end
      it 'priceが全角の場合は登録できない' do
        @item.price = "５００"
        @item.valid?
        expect(@item.errors.full_messages).to include("Price  must be half-size charactor and be setting range.")
      end
      it 'priceが300未満の場合は登録できない' do
        @item.price = 200
        @item.valid?
        expect(@item.errors.full_messages).to include("Price  must be half-size charactor and be setting range.")
      end
      it 'priceが9999999より大きければの場合は登録できない' do
        @item.price = 99999999
        @item.valid?
        expect(@item.errors.full_messages).to include("Price  must be half-size charactor and be setting range.")
      end
      it 'userが紐づいていなければ登録できない' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('User must exist')
      end
    end
  end
end