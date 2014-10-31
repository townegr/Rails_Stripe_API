class PurchasesController < ApplicationController
  def new
  end

  def create
    # Amount in cents
    @amount = 2500

    customer = Stripe::Customer.create(
      email: 'customer@whatsmytally.com',
      card: params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      customer: customer.id,
      amount: @amount,
      description: 'Tally\'s Customer',
      currency: 'usd'
    )

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to purchases_path
  end
end
