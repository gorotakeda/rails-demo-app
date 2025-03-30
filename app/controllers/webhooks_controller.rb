class WebhooksController < ApplicationController
  skip_before_action :verify_authenticity_token

  def stripe
    Rails.logger.info "Webhook received from Stripe"
    payload = request.body.read
    sig_header = request.env['HTTP_STRIPE_SIGNATURE']
    endpoint_secret = ENV['STRIPE_WEBHOOK_SECRET']
    
    Rails.logger.info "Endpoint secret: #{endpoint_secret.present? ? 'present' : 'missing'}"
    
    begin
      event = Stripe::Webhook.construct_event(
        payload, sig_header, endpoint_secret
      )
      Rails.logger.info "Event type: #{event.type}"
    rescue JSON::ParserError => e
      Rails.logger.error "Invalid payload: #{e.message}"
      render json: {error: e.message}, status: 400
      return
    rescue Stripe::SignatureVerificationError => e
      Rails.logger.error "Invalid signature: #{e.message}"
      render json: {error: e.message}, status: 400
      return
    end

    # イベント処理
    case event.type
    when 'checkout.session.completed'
      Rails.logger.info "Processing checkout.session.completed event"
      handle_checkout_session_completed(event.data.object)
    end

    render json: {received: true}
  end

  private

  def handle_checkout_session_completed(session)
    # セッションからメタデータを取得
    metadata = session.metadata
    
    # 予約レコードを作成
    reservation = Reservation.create!(
      user_id: metadata.user_id,
      prayer_type_id: metadata.prayer_type_id,
      reserved_date: metadata.reserved_date,
      time_slot_id: metadata.time_slot_id,
      number_of_people: metadata.number_of_people,
      note: metadata.note,
      status: 'confirmed',
      payment_intent_id: session.payment_intent
    )
    
    # ここに決済完了後の処理を追加（メール送信など）
    # UserMailer.reservation_confirmed(reservation).deliver_later
  end
end 