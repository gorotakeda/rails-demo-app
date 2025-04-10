# frozen_string_literal: true

class AddDeviseToUsers < ActiveRecord::Migration[7.1]
  def self.up
    change_table :users do |t|
      ## Database authenticatable
      t.change :email, :string, null: false, default: "" unless column_exists?(:users, :email)
      
      # encrypted_passwordが存在しない場合のみ追加
      unless column_exists?(:users, :encrypted_password)
        t.string :encrypted_password, null: false, default: ""
      end

      ## Recoverable
      t.string   :reset_password_token unless column_exists?(:users, :reset_password_token)
      t.datetime :reset_password_sent_at unless column_exists?(:users, :reset_password_sent_at)

      ## Rememberable
      t.datetime :remember_created_at unless column_exists?(:users, :remember_created_at)

      ## Trackable
      t.integer  :sign_in_count, default: 0, null: false unless column_exists?(:users, :sign_in_count)
      t.datetime :current_sign_in_at unless column_exists?(:users, :current_sign_in_at)
      t.datetime :last_sign_in_at unless column_exists?(:users, :last_sign_in_at)
      t.string   :current_sign_in_ip unless column_exists?(:users, :current_sign_in_ip)
      t.string   :last_sign_in_ip unless column_exists?(:users, :last_sign_in_ip)

      # password_digestカラムが存在する場合のみ削除
      t.remove :password_digest if column_exists?(:users, :password_digest)
    end

    # インデックスが存在しない場合のみ追加
    unless index_exists?(:users, :email)
      add_index :users, :email, unique: true
    end
    
    unless index_exists?(:users, :reset_password_token)
      add_index :users, :reset_password_token, unique: true
    end
  end

  def self.down
    # By default, we don't want to make any assumption about how to roll back a migration when your
    # model already existed. Please edit below which fields you would like to remove in this migration.
    raise ActiveRecord::IrreversibleMigration
  end
end
