class AddPaymentIntentIdToReservations < ActiveRecord::Migration[7.1]
  def change
    add_column :reservations, :payment_intent_id, :string
  end
end
