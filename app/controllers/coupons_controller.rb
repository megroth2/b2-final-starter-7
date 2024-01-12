class CouponsController < ApplicationController
  def create
    @coupon = Coupon.create!(coupon_params)
  end

  def index
    @merchant = Merchant.find(params[:merchant_id])
  end

  def show
    @coupon = Coupon.find(params[:id])
    @merchant = Merchant.find(params[:merchant_id])
  end

  private

  def coupon_params
    params.permit(:id, :name, :code, :amount_off, :active, :merchant_id, :created_at, :updated_at)
  end

end