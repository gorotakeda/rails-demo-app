class ReservationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @reservations = current_user.reservations.order(created_at: :desc)
    
    # 決済成功時の通知
    flash.now[:notice] = "決済が完了し、予約が確定しました" if params[:success]
  end

  def new
    @reservation = current_user.reservations.build
    # キャンセルされた場合の通知
    flash.now[:alert] = "決済がキャンセルされました。再度お試しください。" if params[:canceled]
  end

  def create
    # フォームから送信された予約情報を保存
    @reservation = current_user.reservations.build(reservation_params)
    
    # フォームの検証
    if @reservation.valid?
      # 有効な場合は決済ページに遷移するためのフォームを表示
      render :confirm
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @reservation = current_user.reservations.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to reservations_path, alert: "該当する予約が見つかりませんでした"
  end

  def confirm
    @reservation = current_user.reservations.build(reservation_params)
    
    if @reservation.invalid?
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