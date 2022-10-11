class BaggagesController < ApplicationController
  before_action :set_baggage, only: %i[ show edit update destroy ]
  #before_action :other_user, only: %i[ index new create ]
  #before_action :other_user_existing, only: %i[ show edit update destroy ]

  # GET /baggages or /baggages.json
  def index
    if params[:reservation_id].present?
      @baggages = Baggage.where(reservation_id: params[:reservation_id])
    end
  end

  # GET /baggages/1 or /baggages/1.json
  def show
  end

  # GET /baggages/new
  def new
    @baggage = Baggage.new
    @reservation = Reservation.find(params[:reservation_id])
  end

  # GET /baggages/1/edit
  def edit
    @reservation = Reservation.find(@baggage.reservation_id)
  end

  # POST /baggages or /baggages.json
  def create
    @baggage = Baggage.new(baggage_params)

    respond_to do |format|
      if @baggage.save
        @reservation = Reservation.find(params[:baggage][:reservation_id])
        @reservation.cost = @reservation.cost + @baggage.cost
        @reservation.save
        format.html { redirect_to baggage_url(@baggage), notice: "Baggage was successfully created." }
        format.json { render :show, status: :created, location: @baggage }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @baggage.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /baggages/1 or /baggages/1.json
  def update
    old_baggage_cost = @baggage.cost
    respond_to do |format|
      if @baggage.update(baggage_params)
        @reservation = Reservation.find(params[:baggage][:reservation_id])
        @reservation.cost = @reservation.cost - old_baggage_cost + @baggage.cost
        @reservation.save
        format.html { redirect_to baggage_url(@baggage), notice: "Baggage was successfully updated." }
        format.json { render :show, status: :ok, location: @baggage }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @baggage.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /baggages/1 or /baggages/1.json
  def destroy
    @reservation = Reservation.find(@baggage.reservation_id)
    @reservation.cost = @reservation.cost - @baggage.cost
    @reservation.save

    @baggage.destroy

    respond_to do |format|
      format.html { redirect_to baggages_path(:reservation_id => @baggage.reservation_id), notice: "Baggage was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_baggage
      @baggage = Baggage.find(params[:id])
    end

    def other_user
      if @reservation.nil?
        @reservation = Reservation.find_by(id: params["reservation_id"])
      end
      if (!@reservation.nil? && !isAdmin? && @reservation.user_id != current_user["id"])
        redirect_to root_path
      end

      if (@reservation.nil?)
        redirect_to root_path
      end
    end

    # Only allow a list of trusted parameters through.
    def baggage_params
      params.require(:baggage).permit(:id, :weight, :cost, :reservation_id)
    end
end
