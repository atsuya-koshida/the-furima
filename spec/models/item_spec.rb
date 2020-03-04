require 'rails_helper'

RSpec.describe Item, type: :model do
  describe "#create" do
    # let(:image) {File.open("#{Rails.root}/spec/fixtures/test_image.jpg")}
    # before do
    #   FactoryBot.create(:image, item: FactoryBot.create(:item))
    # end
    let(:image) { create(:image) }

    it "title、description、condition_id、postage_id、prefecture_id、schedule_id、price、category、user、imageがあれば出品できる" do
      expect(build(:item)).to be_valid
    end

    it "titleが40字の場合は出品できる" do
      expect(build(:item, title: "あ" * 40)).to be_valid
    end

    it "descriptionが1000文字の場合は出品できる" do
      expect(build(:item, description: "あ" * 1000)).to be_valid
    end

    it "priceが300円の場合は出品できる" do
      expect(build(:item, price: 300)).to be_valid
    end

    it "priceが9,999,999円の場合は出品できる" do
      expect(build(:item, price: 9999999)).to be_valid
    end
  
    it "titleが空では出品できない" do
      expect(build(:item, title: "")).to_not be_valid
    end

    it "titleが40字を越えている場合は出品できない" do
      item = build(:item, title: "あ" * 41)
      item.valid?
      expect(item.errors[:title][0]).to include("is too long")
    end

    it "descriptionが空では出品できない" do
      item = build(:item, description: "")
      item.valid?
      expect(item.errors[:description][0]).to include("is too short")
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
      expect(item.errors[:price][0]).to include("is not included in the list")
    end

    it "priceが9,999,999円より高い場合は出品できない" do
      item = build(:item, price: 10000000)
      item.valid?
      expect(item.errors[:price][0]).to include("is not included in the list")
    end

    it "priceが文字列の場合は出品できない" do
      item = build(:item, price: "aaaa")
      item.valid?
      expect(item.errors[:price][0]).to include("is not included in the list")
    end

    it "condition_idが空では出品できない" do
      expect(build(:item, condition_id: nil)).to_not be_valid
    end

    it "postage_idが空では出品できない" do
      expect(build(:item, postage_id: nil)).to_not be_valid
    end

    it "prefecture_idが空では出品できない" do
      expect(build(:item, prefecture_id: nil)).to_not be_valid
    end

    it "schedule_idが空では出品できない" do
      expect(build(:item, schedule_id: nil)).to_not be_valid
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