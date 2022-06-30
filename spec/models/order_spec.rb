require 'rails_helper'

RSpec.describe PurchaseHistory, type: :model do
  before do
    user = FactoryBot.create(:user)
    item = FactoryBot.create(:item)
    @order = FactoryBot.build(:order, user_id: user.id, item_id: item.id)
    sleep 0.1
  end
  describe "商品購入機能" do
  context '内容に問題ない場合' do
    it 'すべての値が正しく入力されていれば購入できること' do
      expect(@order).to be_valid
    end
    it 'buildingは空でも購入できること' do
      @order.building = ""
      expect(@order).to be_valid
    end
  end

  context '内容に問題がある場合' do
    it 'postal_codeが空だと保存できないこと' do
      @order.postal_code = ""
      @order.valid?
      expect(@order.errors.full_messages).to include("Postal code can't be blank")
    end
    it 'postal_codeが半角のハイフンを含んだ正しい形式でないと保存できないこと' do
      @order.postal_code = "0000000"
      @order.valid?
      expect(@order.errors.full_messages).to include("Postal code is invalid")
    end
    it 'prefectureを選択していないと保存できないこと' do
      @order.prefecture_id = 1
      @order.valid?
      expect(@order.errors.full_messages).to include("Prefecture can't be blank")
    end
    it 'cityが空だと保存できないこと' do
      @order.city = ""
      @order.valid?
      expect(@order.errors.full_messages).to include("City can't be blank")
    end
    it 'street_addressが空だと保存できないこと' do
      @order.street_address = ""
      @order.valid?
      expect(@order.errors.full_messages).to include("Street address can't be blank")
    end
    it 'phone_numberが空だと保存できないこと' do
      @order.phone_number = ""
      @order.valid?
      expect(@order.errors.full_messages).to include("Phone number can't be blank")
    end
    it 'phone_numberに"-"が含まれていると保存できないこと' do
      @order.phone_number = "000-0000-0000"
      @order.valid?
      expect(@order.errors.full_messages).to include("Phone number is invalid. Input only number")
    end
    it 'phone_numberが9桁だと保存できないこと' do
      @order.phone_number = "000000000"
      @order.valid?
      expect(@order.errors.full_messages).to include("Phone number is invalid. Input only number")
    end
    it 'phone_numberが12桁だと保存できないこと' do
      @order.phone_number = "000000000000"
      @order.valid?
      expect(@order.errors.full_messages).to include("Phone number is invalid. Input only number")
    end
    it 'itemが紐付いていないと保存できないこと' do
      @order.item_id = nil
      @order.valid?
      expect(@order.errors.full_messages).to include("Item can't be blank")
    end
    it 'userが紐付いていないと保存できないこと' do
      @order.user_id = nil
      @order.valid?
      expect(@order.errors.full_messages).to include("User can't be blank")
    end
    it "tokenが空では登録できないこと" do
      @order.token = nil
      @order.valid?
      expect(@order.errors.full_messages).to include("Token can't be blank")
    end
  end
end
end