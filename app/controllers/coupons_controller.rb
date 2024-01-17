class CouponsController < ApplicationController
  def new
    @merchant = Merchant.find(params[:merchant_id])
  end
  
  def create
    @merchant = Merchant.find(params[:merchant_id])
    @coupon = Coupon.create!(coupon_params)
    
    if @merchant.max_coupons_activated?
      @coupon.update(coupon_params.merge(active: false))
    else
      @coupon.update(coupon_params)
    end

    redirect_to merchant_coupons_path(@merchant)
  end

  def index
    @merchant = Merchant.find(params[:merchant_id])
  end

  def show
    @coupon = Coupon.find(params[:id])
    @merchant = Merchant.find(params[:merchant_id])
  end

  def update
    @coupon = Coupon.find(params[:id])
    @merchant = Merchant.find(params[:merchant_id])

    @coupon.update(coupon_params)

    redirect_to merchant_coupon_path(@merchant, @coupon)
  end

  private

  def coupon_params
    params.permit(:id, :name, :code, :amount_off, :active, :merchant_id, :created_at, :updated_at)
  end

end