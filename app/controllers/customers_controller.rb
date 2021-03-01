class CustomersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_customer, only: [:show, :edit, :update, :destroy]
  before_action :set_vehicle_options, only: [:edit, :new, :create, :update]
  helper_method :sort_column, :sort_direction, :current_page

  def index
    @vehicle_options = Vehicle.distinct.pluck(:vehicle_type).push("all").sort
    @page = params[:page]
    initial_query = Customer.includes(:vehicle)
                            .order(sort_column + " " + sort_direction)
                            .references(:vehicle)
                            .paginate(@page)

    if params[:vehicle_type] && params[:vehicle_type] != 'all'
      @customers = initial_query.where(:vehicles => {:vehicle_type => params[:vehicle_type]})
    elsif params[:search]
      @customers = initial_query.where("concat(first_name, ' ', last_name) LIKE ? OR email LIKE ?", "%#{params[:search].downcase}%", "%#{params[:search].downcase}%")
    else
      @customers = initial_query
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
    @customer.build_vehicle
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
    params.require(:customer).permit(:first_name, :last_name, :email, vehicle_attributes: [:id, :name, :length, :vehicle_type])
  end

  def set_vehicle_options
    @total_vehicle_options = Vehicle.vehicle_types.map{|k,v| k}
  end

  def sort_column
    SORTABLE_COLUMN_TYPES.include?(params[:sort]) ? params[:sort] : "last_name"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

  def current_page
    params.fetch(:page, 0)
  end

end
