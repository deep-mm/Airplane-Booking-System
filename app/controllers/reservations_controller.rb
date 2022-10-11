class ReservationsController < ApplicationController
  before_action :set_reservation, only: %i[ show edit update destroy ]
  before_action :other_user, only: %i[ index ]
  before_action :other_user_existing, only: %i[ show edit update destroy ]

  # GET /reservations or /reservations.json
  def index
    if (current_user["id"].to_s==params[:user_id] && isAdmin?)
      @reservations = Reservation.all
    else
      @reservations = Reservation.where(user_id: params[:user_id])
    end
  end

  # GET /reservations/1 or /reservations/1.json
  def show
  end

  # GET /reservations/new
  def new
    @reservation = Reservation.new
    @reservation.confirmation_number = Array.new(10){[*"A".."Z", *"0".."9"].sample}.join

    if @flight.nil?
      @flight = Flight.find(params[:flight_id])
    end
    @user = current_user
    @capacity = get_current_capacity(@flight)
  end

  # GET /reservations/1/edit
  def edit
    if @flight.nil?
      @flight = Flight.find_by(id: @reservation.flight_id)
      @capacity = get_current_capacity(@flight) + @reservation.passengers
    end
    @old_passengers = @reservation.passengers
    @original_cost = @reservation.cost
  end

  # POST /reservations or /reservations.json
  def create
    @reservation = Reservation.new(reservation_params)

    @reservation.confirmation_number = Array.new(10){[*"A".."Z", *"0".."9"].sample}.join
    @user = User.find(params[:reservation][:user_id])
    @reservation.user = @user # insert the correct call to an appropriate function here
    # We update the original product quantity

    @flight = Flight.find(params[:reservation][:flight_id])
    @capacity = get_current_capacity(@flight) - @reservation.passengers
    if @capacity == 0
      @flight.status = "complete"
    end

    respond_to do |format|
      if @reservation.save
        @flight.save
        format.html { redirect_to reservation_url(@reservation), notice: "Reservation was successfully created. The confirmation number is " + @reservation.confirmation_number  }
        format.json { render :show, status: :created, location: @reservation }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @reservation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reservations/1 or /reservations/1.json
  def update
    old_passengers = @reservation.passengers
    respond_to do |format|
      if @reservation.update(reservation_params)
        @flight = Flight.find(@reservation.flight_id)
        @capacity = get_current_capacity(@flight) - @reservation.passengers + old_passengers
        if @capacity > 0
          @flight.status = "available"
        else
          @flight.status = "complete"
        end
        @flight.save
        format.html { redirect_to reservation_url(@reservation), notice: "Reservation was successfully updated." }
        format.json { render :show, status: :ok, location: @reservation }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @reservation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reservations/1 or /reservations/1.json
  def destroy
    @flight = Flight.find(@reservation.flight_id)
    @capacity = get_current_capacity(@flight) + @reservation.passengers
    if @capacity > 0
      @flight.status = "available"
    end
    @reservation.destroy

    respond_to do |format|
      @flight.save
      format.html { redirect_to reservations_path(:user_id => current_user["id"]), notice: "Reservation was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reservation
      @reservation = Reservation.find_by(id: params[:id])
    end

    def get_current_capacity (flight)
      begin
        return flight.capacity - Reservation.where(flight_id: flight.id).map{|x| x.passengers}.inject {|v, n| v+n}
      rescue
        return flight.capacity
      end
    end
    def other_user
      if (!isAdmin? && params[:user_id] != current_user["id"].to_s)
        redirect_to root_path
      end
    end

    def other_user_existing
      if (!@reservation.nil? && !isAdmin? && @reservation.user_id != current_user["id"])
        redirect_to root_path
      end

      if (@reservation.nil?)
        redirect_to root_path
      end
    end

    # Only allow a list of trusted parameters through.
    def reservation_params
      params.require(:reservation).permit(:id, :passengers, :reservation_class, :amenities, :cost, :confirmation_number, :flight_id)
    end
end
