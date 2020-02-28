require 'rails_helper'
describe Card do
  describe '#pay' do
    it "is invalid without a card_id" do
      card = build(:card, card_id: "")
      card.valid?
      expect(card.errors[:card_id]).to include("can't be blank")
    end
  end
end