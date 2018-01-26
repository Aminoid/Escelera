class CarsController < ApplicationController
  before_action :authorize_user, only: [:index, :show]
  before_action :authorize_admin, only: [:new, :create, :destroy, :edit, :update]
  before_action :set_car, only: [:show, :edit, :update, :destroy]

  def new
    @car = Car.new
  end

  def create
    @car = Car.new(car_params)

    respond_to do |format|
      if @car.save
        format.html {redirect_to cars_path, notice: 'Car was successfully created.'}
        format.json {render action: 'show', status: :created, location: @car}
      else
        format.html {render action: 'new'}
        format.json {render json: @car.errors, status: :unprocessable_entity}
      end
    end
  end

  def update
    @car = Car.find(params[:id])
    if Booking.where("car_id = ? AND status == 2", @car.id).to_a().length > 0 then
      flash[:notice] = "Car Number: #{@car.number.capitalize} is already checkedout. Please manage booking before updating this Car"
    else
      if @car.update_attributes(car_params)
        format.html { redirect_to cars_path, notice: 'Car was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @car.errors, status: :unprocessable_entity }
      end
    end
    respond_to do |format|
        format.html { redirect_to cars_path}
        format.json { head :no_content }
      end
    end

  def edit
    @car = Car.find(params[:id])
  end

  def destroy
    if Booking.where("car_id = ? AND status == 1 OR status == 2", @car.id).to_a().length > 0 then
      flash[:notice] = "Car Number: #{@car.number.capitalize} have pending bookings. Please manage booking before deleting this Car"
    else
      @car.destroy
      flash[:notice] = "Car Number: #{@car.number.capitalize} was successfully deleted."
    end
    respond_to do |format|
      format.html {redirect_to cars_url}
      format.json {head :no_content}
    end
  end

  def index
    @search = Car.search(params[:q])
    @cars = @search.result
    if (current_user.try(:user?))
      @booking = Booking.where(:user_id => current_user.id).where.not(status: 3).to_a()
    else
      @booking = []
    end

    if @booking.length <= 0 then
      @cars.each do |car|
        car.status = car_status car
      end
    else
      @cars = []
    end
    @cars
  end

  def show
  end

  def search
    @search = Car.search(params[:q])
    @cars = @search.result
  end

  def bookings
    @bookings = Booking.where(:car_id => params[:car_id])
  end

  def authorize_user
    return unless !user_signed_in?
    redirect_to root_path, alert: 'Please login first!'
  end

  def authorize_admin
    return unless !current_user.try(:admin?) and !current_user.try(:superadmin?)
    redirect_to root_path, alert: 'This page is for Admin or Super Admin only!'
  end

  private

    def set_car
      @car = Car.find(params[:id])
    end

  def car_params
    params.require(:car).permit(:model, :manufacturer, :number,
                                :rate, :style, :location)
  end

  def car_status car
    @booking = Booking.where("car_id = ? AND pickup_time <= ? AND return_time >=  ?", car.id, DateTime.now.to_s(:db), DateTime.now.to_s(:db))
    status = "Available"
    if @booking.exists?
      booking = @booking.last
      user = User.find(booking["user_id"])
      status = booking["status"].capitalize + " by " + view_context.link_to(user.name, user_bookings_url(user.id))
    end
    status
  end
end
