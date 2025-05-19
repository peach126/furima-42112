# README

# テーブル設計

## users テーブル

| Column             | Type   | Options     |
| ------------------ | ------ | ----------- |
| nickname           | string | null: false |
| email              | string | null: false, unique: true |
| encrypted_password | string | null: false |
| family_name        | string | null: false |
| first_name         | string | null: false |
| family_name_kana   | string | null: false |
| first_name_kana    | string | null: false |
| birth_year         | string | null: false |
| birth_month        | string | null: false |
| birth_day          | string | null: false |

### Association

- has_many :items
- has_many :orders
- has_one  :shipping

## items テーブル

| Column           | Type       | Options     |
| ---------------- | ---------- | ----------- |
| image            | text       | null: false |
| item_name        | string     | null: false |
| item_description | string     | null: false |
| item_condition   | text       | null: false |
| shipping_fee     | boolean    | null: false |
| shipping_area    | text       | null: false |
| delivery_time    | datetime   | null: false |
| price            | integer    | null: false |
| user             | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_many   :oders

## orders テーブル

| Column    | Type       | Options                        |
| --------- | ---------- | ------------------------------ |
| user      | references | null: false, foreign_key: true |
| item      | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_many   :items
- has_one    :shipping

## shippings テーブル

| Column       | Type       | Options                        |
| ------------ | ---------- | ------------------------------ |
| postal_code  | text       | null: false                    |
| prefecture   | text       | null: false                    |
| city         | text       | null: false                    |
| address      | text       | null: false                    |
| building     | text       | null: false                    |
| phone_number | text       | null: false                    |
| user         | references | null: false, foreign_key: true |

### Association

- has_one :order
- has_one :user