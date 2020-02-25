# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

# furima DB設計
## usersテーブル
Column|Type|Options|
|------|----|-------|
|nickname|string|null: false|
|email|string|null: false|
|password|integer|null: false|
|image|string|
|lastname|string|null: false|
|firstname|string|null: false|
|lastname_kana|string|null: false|
|firstname_kana|string|null: false|
|birthday|integer|null: false|
### Association
- has_many :items
- has_many :addresses
- has_many :cards

## itemsテーブル
|Column|Type|Options|
|------|----|-------|
|title|string|null: false|
|description|text|null: false|
|condition|string|null: false|
|postage|string|null: false|
|prefecture|string|null: false|
|schedule|string|null: false|
|price|integer|null: false|
|user_id|references|null: false, foreign_key: true|
|category_id|references|null: false, foreign_key: true|
|bought_user_id|integer|
### Association
- belongs_to :user
- belongs_to :category
- has_many :images

## addressesテーブル
|Column|Type|Options|
|------|----|-------|
|lastname|string|null: false|
|firstname|string|null: false|
|lastname_kana|string|null: false|
|firstname_kana|string|null: false|
|postal_code|inter|null: false|
|prefecture|string|null: false|
|city|string|null: false|
|house_num|string|null: false|
|detail|string|
|tel_num|integer|
|user_id|integer|null: false, foreign_key: true|
### Association
- belongs_to :user

## categoriesテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|ancestry|string|null: false|
### Association
- has_many :items

## cardsテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|references|null: false, foreign_key: true|
|card_id|integer|null: false|
|customer_id|integer|null: false|
### Association
- belongs_to :user

## imagesテーブル
|Column|Type|Options|
|------|----|-------|
|image|string|null: false|
|item_id|references|null: false, foreign_key: true|
### Association
- belongs_to :item