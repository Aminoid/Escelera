class BookingsController < ApplicationController
  before_action :authorize_user
  before_action :set_car
  before_action :set_booking, only: [:show, :edit, :update, :destroy]

  def new
    @booking = Booking.new
    @users = User.where("role" => 0).to_a()
    print "Hello: ", @users
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.car_id = @car.id
    @users = User.where("role" => 0).to_a()
    @check = true
    if !booking_params.key?("user_id") then
      @booking.user_id = current_user.id
    else
      if Booking.where("user_id = ? AND status != 3", @booking.user_id).to_a().length > 0 then
        @check = false
      end
    end

    @pickup = @booking.pickup_time
    @return = @booking.return_time

    @temp = Booking.where("pickup_time > ? and return_time < ?", @pickup, @pickup).or(
            Booking.where("pickup_time > ? and return_time < ?", @return, @return)).to_a()

    @pass = false
    @msg = ""

    if @temp.length <= 0 then
      if ((@return - @pickup)/ 1.day).to_i <= 7 then
        if ((@return - @pickup)/ 1.hour).to_i >= 1 then
          if @check then
            if @booking.save then
              @pass = true
            end
          else
            @msg = "Error: This user has already one reserved car. Please return it first."
          end
        else
          @msg = "Error: Minimum rental time is atleast 1 hour"
        end
      else
        @msg = "Error: Booking period can't be more than 7 days"
      end
    else
      @msg = "Error: Some car is already booked within that period"
    end

    respond_to do |format|
      if @pass then
        if current_user.try(:user?) then
          format.html { redirect_to user_bookings_url(current_user.id), notice: 'Booking was successfully created' }
        else
          format.html { redirect_to :root, notice: 'Booking was successfully created'}
        end
      else
        flash[:notice] = @msg
        format.html { render action: 'new' }
        format.json { render json: @booking.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
  end

  def edit
  end

  def destroy
  end

  def index
  end

  def check_out
    @booking = Booking.find(params[:id])
    @booking.status = 2
    respond_to do |format|
      if @booking.save then
        @notice = "You have successfully checked out the car. Please return on time."
      else
        @notice = 'Something went wrong while checking out. Please try again'
      end
      if current_user.try(:user?) then
        @url = user_bookings_url(current_user.id)
      else
        @url = :root
      end
      format.html { redirect_to @url, notice: @notice }
    end
  end

  def return
    @booking = Booking.find(params[:id])
    @booking.status = 3
    respond_to do |format|
      if @booking.save then
        @notice = "You have successfully returned your car"
      else
        @notice = 'Something went wrong while returning the car. Please try again'
      end
      if current_user.try(:user?) then
        @url = user_bookings_url(current_user.id)
      else
        @url = :root
      end
      format.html { redirect_to @url, notice: @notice }
    end
  end

  def cancel
    @booking = Booking.find(params[:id])
    @booking.delete
    if current_user.try(:admin?) then
      redirect_to user_bookings_url(current_user.id)
    else
      redirect_to :root
    end
  end

  def show
    @bookings = Booking.find(params[:user_id])
  end

  def authorize_user
    return unless !user_signed_in?
    redirect_to root_path, alert: 'Please login first!'
  end

  def authorize_admin
    return unless !current_user.try(:admin?) and !current_user.try(:superadmin?)
    redirect_to root_path, alert: 'This page is for Admin or Super Admin only!'
  end

  def set_car
    if params.key?("car_id")
      @car = Car.find(params[:car_id])
    else
      @car = ""
    end
  end

  def set_booking
    @booking = Booking.find(params[:id])
  end

  private
    def booking_params
      params.require(:booking).permit(:pickup_time, :return_time, :user_id)
    end
end
