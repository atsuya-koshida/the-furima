require 'rails_helper'

RSpec.describe Card, type: :model do
  describe Card do
    describe '#pay' do
      it "is valid with all" do
        expect(build(:card)).to be_valid
      end

      it "is invalid without a card_id" do
        card = build(:card, card_id: "")
        card.valid?
        expect(card.errors[:card_id]).to include("can't be blank")
      end

      it "is invalid without a customer_id" do
        card = build(:card, customer_id: "")
        card.valid?
        expect(card.errors[:customer_id]).to include("can't be blank")
      end
    end
  end
end