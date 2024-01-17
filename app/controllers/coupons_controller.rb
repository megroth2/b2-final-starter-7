class CouponsController < ApplicationController
  def new
    @merchant = Merchant.find(params[:merchant_id])
    # redirect_to merchant_coupons_path(@merchant)
  end
  
  def create
    @merchant = Merchant.find(params[:merchant_id])
    @coupon = Coupon.create!(coupon_params)
    redirect_to merchant_coupons_path(@merchant)
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