class CustomersController < ApplicationController
  require 'will_paginate/array'
  before_action :authenticate_user!
  before_action :set_customer, only: [:show, :edit, :update, :destroy]
  before_action :set_vehicle_options, only: [:edit, :new, :create, :update]

  def index
    @vehicle_options = Customer.distinct.pluck(:vehicle_type).push("all").sort

    if params[:vehicle_type]
      if params[:vehicle_type] == "all"
        @customers = Customer.all
                              .sort_by(&:last_name)
                              .paginate(page: params[:page], per_page: 10)
      else
        @customers = Customer.where(vehicle_type: params[:vehicle_type])
                              .sort_by(&:last_name)
                              .paginate(page: params[:page], per_page: 10)
      end
    elsif params[:search]
      @customers = Customer.where("concat(first_name, ' ', last_name) LIKE ? OR email LIKE ?", "%#{params[:search].downcase}%", "%#{params[:search].downcase}%").paginate(page: params[:page], per_page: 10)
    else
      @customers = Customer.all
                            .sort_by(&:last_name)
                            .paginate(page: params[:page], per_page: 10)
    end
  end

  def import
    Customer.import(params[:file])
    redirect_to customers_path, notice: "Customers Uploaded Successfully"
  end

  def show
  end

  def new
    @customer = Customer.new
  end

  def edit
  end

  def create
    @customer = Customer.new(customer_params)

    respond_to do |format|
      if @customer.save
        format.html { redirect_to @customer, notice: 'Customer was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @customer.update(customer_params)
        format.html { redirect_to @customer, notice: 'Customer was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @customer.destroy
    respond_to do |format|
      format.html { redirect_to customers_url, notice: 'Customer was successfully destroyed.' }
    end
  end

  private

    def set_customer
      @customer = Customer.find(params[:id])
    end

    def customer_params
      params.require(:customer).permit(:first_name, :last_name, :email, :vehicle_type, :vehicle_name, :vehicle_length_ft)
    end

    def set_vehicle_options
      @total_vehicle_options = Customer.vehicle_types.map{|k,v| k}
    end
end
