class FlightsController < ApplicationController
  before_action :set_flight, only: %i[ show edit update destroy ]
  before_action :adminAuthorized, only: %i[ new edit create update destroy ]

  # GET /flights or /flights.json
  def index
    @flights = Flight.all

    if params[:origin_city].present?
      @flights = @flights.where(origin_city_id: params[:origin_city])
    end

    if params[:destination_city].present?
      @flights = @flights.where(destination_city_id: params[:destination_city])
    end

  end

  # GET /flights/1 or /flights/1.json
  def show
  end

  # GET /flights/new
  def new
    @flight = Flight.new
  end

  # GET /flights/1/edit
  def edit
    @existingCapacity = get_current_bookings(@flight)
  end

  # POST /flights or /flights.json
  def create
    @flight = Flight.new(flight_params)

    respond_to do |format|
      if @flight.save
        format.html { redirect_to flight_url(@flight), notice: "Flight was successfully created." }
        format.json { render :show, status: :created, location: @flight }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @flight.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /flights/1 or /flights/1.json
  def update
    respond_to do |format|
      if @flight.update(flight_params)
        if @flight.capacity == get_current_bookings(@flight)
          @flight.status = "complete"
        else
          @flight.status = "available"
        end
        @flight.save
        format.html { redirect_to flight_url(@flight), notice: "Flight was successfully updated." }
        format.json { render :show, status: :ok, location: @flight }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @flight.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /flights/1 or /flights/1.json
  def destroy
    @flight.destroy

    respond_to do |format|
      format.html { redirect_to flights_url, notice: "Flight was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_flight
      @flight = Flight.find(params[:id])
    end

    def get_current_bookings (flight)
      begin
        return Reservation.where(flight_id: flight.id).map{|x| x.passengers}.inject {|v, n| v+n}
      rescue
        return 0
      end
    end

    # Only allow a list of trusted parameters through.
    def flight_params
      params.require(:flight).permit(:id, :name, :origin_city_id, :destination_city_id, :cost,
                                     :capacity, :flight_class, :manufacturer, :status, :origin_city, :destination_city)
    end
end
