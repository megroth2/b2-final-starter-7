class CouponsController < ApplicationController
  def new
    @merchant = Merchant.find(params[:merchant_id])
  end
  
  def create
    @merchant = Merchant.find(params[:merchant_id])
    if Coupon.find_by(code: coupon_params[:code]) # if the code already exists, error
      flash[:alert] = "Error: Code not unique"
    elsif @merchant.max_coupons_activated? # if max coupons are activated for this merchant, create the coupon but set active to false
      @coupon = Coupon.create!(coupon_params.merge(active: false))
      flash[:alert] = "Error: Code created as inactive. The max active coupons allowed has been met for this merchant."
    else
      @coupon = Coupon.create!(coupon_params) # otherwise, create the coupon as 
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

    if @coupon.invoices_pending?
      flash[:alert] = "Error: This coupon cannot be deactivated because it has pending invoices"
    else
      @coupon.update(coupon_params)
    end

    redirect_to merchant_coupon_path(@merchant, @coupon)
  end

  private

  def coupon_params
    params.permit(:id, :name, :code, :amount_off, :active, :merchant_id, :created_at, :updated_at)
  end

end