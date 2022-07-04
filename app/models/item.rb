class Item < ApplicationRecord
extend ActiveHash::Associations::ActiveRecordExtensions
  validates :image,presence: true
  validates :explanation,presence: true
  validates :name,presence: true
  validates :price,presence: true
  validates :price, numericality: {only_integer: true, greater_than_or_equal_to: 300,less_than_or_equal_to: 9999999,message: " must be half-size charactor and be setting range."}, allow_blank: true
  validates :category_id, numericality: {other_than: 1, message: "を選択してください"}
  validates :send_time_id, numericality: {other_than: 1, message: "を選択してください"}
  validates :prefecture_id, numericality: {other_than: 1, message: "を選択してください"}
  validates :postage_id, numericality: {other_than: 1, message: "を選択してください"}
  validates :states_id, numericality: {other_than: 1, message: "を選択してください"} 


  belongs_to :user
  belongs_to :category
  belongs_to :postage
  belongs_to :prefecture
  belongs_to :send_time
  belongs_to :states
  has_one :purchase_history
  has_one_attached :image
end
