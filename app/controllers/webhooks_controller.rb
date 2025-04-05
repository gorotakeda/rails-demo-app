class WebhooksController < ApplicationController
  # CSRFトークン検証をスキップ（外部サービスからのリクエストのため）
  skip_before_action :verify_authenticity_token

  def stripe
    # リクエストボディを読み込む
    request_body = request.body.read
    # Stripeの署名ヘッダーを取得
    sig_header = request.env['HTTP_STRIPE_SIGNATURE']
    # Stripeのエンドポイントシークレットを取得
    endpoint_secret = ENV['STRIPE_WEBHOOK_SECRET']
    
    begin
      # Stripeのイベントを解析
      event = Stripe::Webhook.construct_event(
        request_body, sig_header, endpoint_secret
      )
    rescue JSON::ParserError => e
      # JSON解析エラー時の処理
      render json: {error: e.message}, status: 400
      return
    rescue Stripe::SignatureVerificationError => e
      # 署名検証エラー時の処理
      render json: {error: e.message}, status: 400
      return
    end

    # イベント処理
    if event.type == 'checkout.session.completed'
      # 決済が完了した場合の処理
      handle_checkout_session_completed(event.data.object)
    end

    # リクエストを受け取ったことを確認
    render json: {received: true}
  end

  private

  # 決済が完了した場合の処理
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