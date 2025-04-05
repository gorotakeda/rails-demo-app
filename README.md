## 技術スタック

### 主要なGem

* **Ruby**: 3.1.4
* **Rails**: 7.1.5
* **データベース**: MySQL (mysql2 ~> 0.5)

#### フロントエンド
* Slim (slim-rails) - テンプレートエンジン
* Sass (sass-rails) - CSSプリプロセッサ
* Hotwire (turbo-rails, stimulus-rails) - SPA風のページ更新
* Importmap (importmap-rails) - JavaScriptモジュール管理

#### ユーザー認証
* Devise - 認証機能
* Devise-i18n - Devise日本語化

#### 決済
* Stripe - 決済処理

#### その他
* dotenv-rails - 環境変数管理
* Puma - Webサーバー
* Bootsnap - 起動時間の短縮

### 開発・テスト環境
* Debug - デバッグツール
* Web-console - 例外ページのコンソール
* Capybara - システムテスト
* Selenium Webdriver - ブラウザテスト

## 環境構築の手順

プロジェクトのセットアップについては「環境構築」セクションを参照してください。
