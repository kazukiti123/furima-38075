class Order
  extend ActiveHash::Associations::ActiveRecordExtensions
  include ActiveModel::Model
  attr_accessor :postal_code,:prefecture_id,:city,:street_address,:building,:phone_number,:user_id,:item_id, :token

  with_options presence: true do
    validates :postal_code
    validates :city
    validates :street_address
    validates :phone_number
    validates :token
    validates :user_id
    validates :item_id
  end
    validates :postal_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, masseage:'is invalid. Input with"-"'}, allow_blank: true
    validates :prefecture_id, numericality: {other_than: 1, message: "can't be blank"}
    validates :phone_number, format: {with: /\A\d{10}\z|\A\d{11}\z/, message: "is invalid. Input only number"}, allow_blank: true

  def create
    purchase_history = PurchaseHistory.create(user_id: user_id, item_id: item_id) 
    BuyAddress.create(postal_code: postal_code,prefecture_id: prefecture_id,city: city,street_address: street_address,building: building,phone_number: phone_number,purchase_history_id: purchase_history.id)
  end
end