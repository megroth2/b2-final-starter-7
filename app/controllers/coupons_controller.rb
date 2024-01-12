class CouponsController < ApplicationController
  def create
    @coupon = Coupon.create!(coupon_params)
  end

  private

  def coupon_params
    params.permit(:id, :name, :code, :category, :active, :merchant_id, :created_at, :updated_at)
  end

end