Rails.configuration.stripe = {
  publishable_key: ENV['STRIPE_PUBLISHABLE_KEY'],
  secret_key: ENV['STRIPE_SECRET_KEY']
}

# 開発環境でキーの設定を確認
if Rails.env.development?
  Rails.logger.info "Stripe publishable key: #{Rails.configuration.stripe[:publishable_key]}"
  if Rails.configuration.stripe[:publishable_key].nil?
    Rails.logger.error "STRIPE_PUBLISHABLE_KEY is not set in .env file"
  end
end

Stripe.api_key = Rails.configuration.stripe[:secret_key]
# 有効なAPIバージョンに更新
Stripe.api_version = '2023-10-16' # 現在サポートされている最新バージョンに変更 