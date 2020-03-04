class OrdersController < ApplicationController
  def create
    user = current_user
    pet = Pet.find(params[:pet_id])
    order = Order.create!(state: 'pending',pet: pet,user: user, pet_sku: pet.sku, total_price: pet.price)

    #enters stripe

    session = Stripe::Checkout::Session.create(
    payment_method_types: ['card'],
    line_items: [{
      name: pet.sku,
      images: [pet.photo_url],
      amount: pet.price_cents,
      currency: 'eur',
      quantity: 1
    }],
    success_url: order_url(order),
    cancel_url: order_url(order)
  )

    #update my order with stripe information

    order.update(checkout_session_id: session.id)

    #redirect to payment page
    redirect_to new_order_payment_path(order)


  end

  def show
    @order = current_user.orders.find(params[:id])

  end

  private

  def check_if_payment
    @order.update(state: 'payed')
  end
end
