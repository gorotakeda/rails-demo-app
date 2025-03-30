class CheckoutsController < ApplicationController
  before_action :authenticate_user!

  def create
    # 予約情報をセッションに保存
    session[:reservation_params] = {
      prayer_type_id: params[:prayer_type_id],
      reserved_date: params[:reserved_date],
      time_slot_id: params[:time_slot_id],
      number_of_people: params[:number_of_people],
      note: params[:note]
    }
    
    # プレビュー用に一時オブジェクトを作成
    prayer_type = PrayerType.find(params[:prayer_type_id])
    time_slot = TimeSlot.find(params[:time_slot_id])
    
    # チェックアウトセッションの作成
    checkout_session = create_session(prayer_type, time_slot, params)
    
    # Stripeの決済ページにリダイレクト
    redirect_to checkout_session.url, allow_other_host: true
  end

  private

  def create_session(prayer_type, time_slot, params)
    Stripe::Checkout::Session.create({
      client_reference_id: current_user.id,
      customer_email: current_user.email,
      mode: 'payment',
      payment_method_types: ['card'],
      line_items: [{
        quantity: 1,
        price_data: {
          currency: 'jpy',
          unit_amount: prayer_type.price,
          product_data: {
            name: prayer_type.name,
            description: "#{params[:reserved_date]} #{time_slot.formatted_time}",
            metadata: {
              prayer_type_id: prayer_type.id,
              time_slot_id: time_slot.id
            }
          }
        }
      }],
      metadata: {
        prayer_type_id: prayer_type.id,
        reserved_date: params[:reserved_date],
        time_slot_id: time_slot.id,
        number_of_people: params[:number_of_people],
        note: params[:note],
        user_id: current_user.id
      },
      success_url: "#{root_url}reservations?success=true",
      cancel_url: "#{root_url}reservations/new?canceled=true"
    })
  end
end 