class ReservationsController < ApplicationController
  before_action :authenticate_user!

  def new
    @reservation = current_user.reservations.build
  end

  def create
    @reservation = current_user.reservations.build(reservation_params)
    @reservation.status = "pending"

    if @reservation.save
      redirect_to root_path, notice: "御祈祷の予約が完了しました"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def reservation_params
    params.require(:reservation).permit(
      :prayer_type_id,
      :reserved_date,
      :time_slot_id,
      :number_of_people,
      :note
    )
  end
end 