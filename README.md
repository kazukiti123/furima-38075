# README

## users

|Column             |Type   |Options                  |
|-------------------|-------|-------------------------|
|nickname           |string |null: false              |
|email              |string |unique: true,null: false |
|encrypted_password |string |null: false              |
|first_name_kanji   |string |null: false              |
|last_name_kanji    |string |null: false              |
|first_name_kana    |string |null: false              |
|last_name_kana     |string |null: false              |
|birthday           |date   |null: false              |


### Association
has_many :items
has_many :purchases

## items

|Column             |Type       |Options                        |
|-------------------|-----------|-------------------------------|
|name               |string     |null: false                    |
|explanation        |text       |null: false                    |
|price              |integer    |null: false                    |
|states_id          |integer    |null: false                    |
|postage_id         |integer    |null: false                    |
|prefecture_id      |integer    |null: false                    |
|send_time_id       |integer    |null: false                    |
|category_id        |integer    |null: false                    |
|user               |references |null: false, foreign_key: true |

### Association
belongs_to :user
has_one :purchase_history

## buy_addresses

|Column          |Type        |Options                        |
|----------------|------------|-------------------------------|
|postal_code     |string      |null: false                    |
|prefecture_id   |integer     |null: false                    |
|city            |string      |null: false                    |
|street_address  |string      |null: false                    |
|building        |string      |                               |
|phone_number    |string      |null: false                    |
|purchase_history|references  |null: false, foreign_key: true |


### Association
belongs_to :purchase_history

## purchase_histories

|Column              |Type       |Options                        |
|--------------------|-----------|-------------------------------|
|user                |references |null: false, foreign_key: true |
|item                |references |null: false, foreign_key: true |


### Association
belongs_to :user
belongs_to :item
has_one :shipping_address