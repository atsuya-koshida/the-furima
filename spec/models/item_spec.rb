require 'rails_helper'

RSpec.describe Item, type: :model do
  describe "#create" do

    it "title、description、condition_id、postage_id、prefecture_id、schedule_id、price、category、user、imageがあれば出品できる" do
      expect(build(:item)).to be_valid
    end

    it "titleが40字の場合は出品できる" do
      item = build(:item, title: "あ" * 40)
      item.valid?
      expect(item).to be_valid
    end

    it "descriptionが1000文字の場合は出品できる" do
      item = build(:item, description: "あ" * 1000)
      item.valid?
      expect(item).to be_valid
    end

    it "priceが300円の場合は出品できる" do
      item = build(:item, price: 300)
      item.valid?
      expect(item).to be_valid
    end

    it "priceが9,999,999円の場合は出品できる" do
      item = build(:item, price: 9999999)
      item.valid?
      expect(item).to be_valid
    end
  
    it "titleが空では出品できない" do
      item = build(:item, title: "")
      item.valid?
      expect(item.errors[:title]).to include("is too short")
    end

    it "titleが40字を越えている場合は出品できない" do
      item = build(:item, title: "あ" * 41)
      item.valid?
      expect(item.errors[:title][0]).to include("is too long")
    end

    it "descriptionが空では出品できない" do
      item = build(:item, description: "")
      item.valid?
      expect(item.errors[:description]).to include("is too short")
    end

    it "descriptionが1000文字を越えている場合は出品できない" do
      item = build(:item, description: "あ" * 1001)
      item.valid?
      expect(item.errors[:description][0]).to include("is too long")
    end

    it "priceが空では出品できない" do
      item = build(:item, price: nil)
      item.valid?
      expect(item.errors[:price]).to include("is not included in the list")
    end

    it "priceが300円未満では出品できない" do
      item = build(:item, price: 299)
      item.valid?
      expect(item.errors[:price]).to include("greater_than_or_equal_to")
    end

    it "priceが9,999,999円より高い場合は出品できない" do
      item = build(:item, price: 10000000)
      item.valid?
      expect(item.errors[:price]).to include("less_than_or_equal_to")
    end

    it "priceが文字列の場合は出品できない" do
      item = build(:item, price: "aaaa")
      item.valid?
      expect(item.errors[:price]).to include("not a number")
    end

    it "condition_idが空では出品できない" do
      item = build(:item, condition_id: nil)
      item.valid?
      expect(item.errors[:condition_id]).to include("can't be blank")
    end

    it "postage_idが空では出品できない" do
      item = build(:item, postage_id: nil)
      item.valid?
      expect(item.errors[:postage_id]).to include("can't be blank")
    end

    it "prefecture_idが空では出品できない" do
      item = build(:item, prefecture_id: nil)
      item.valid?
      expect(item.errors[:prefecture_id]).to include("can't be blank")
    end

    it "schedule_idが空では出品できない" do
      item = build(:item, schedule_id: nil)
      item.valid?
      expect(item.errors[:schedule_id]).to include("can't be blank")
    end

    it "categoryが空では出品できない" do
      item = build(:item, category_id: nil)
      item.valid?
      expect(item.errors[:category_id]).to include("can't be blank")
    end

    it "userが空では出品できない" do
      item = build(:item, user_id: nil)
      item.valid?
      expect(item.errors[:user_id]).to include("can't be blank")
    end
  end
end