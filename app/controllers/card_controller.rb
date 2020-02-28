class CardController < ApplicationController
  require "payjp"
  before_action :set_card, only: [:new, :show, :delete]
  def new
  end

  def pay
    Payjp.api_key = Rails.application.credentials[:payjp][:private_key]
    if params['payjp-token'].blank?
      redirect_to action: "new"
    else
      customer = Payjp::Customer.create(
      description: '登録テスト',
      email: current_user.email,
      card: params['payjp-token'],
      metadata: {user_id: current_user.id}
      )
      @card = Card.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
      if @card.save
        redirect_to action: "show"
      else
        redirect_to action: "pay"
      end
    end
  end

  def delete
    if @card.present?
      Payjp.api_key = Rails.application.credentials[:payjp][:private_key]
      customer = Payjp::Customer.retrieve(@card.customer_id)
      customer.delete
      @card.delete
    end
      redirect_to action: "new"
  end

  def show
    if @card.blank?
      redirect_to action: "new" 
    else
      Payjp.api_key = Rails.application.credentials[:payjp][:private_key]
      customer = Payjp::Customer.retrieve(@card.customer_id)
      @default_card_information = customer.cards.retrieve(@card.card_id)
    end
  end

  private
  def set_card
    @card = Card.find_by(user_id: current_user)
  end
end
