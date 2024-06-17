class AttendeesController < ApplicationController
  before_action :set_attendee, only: %i[show edit update destroy]

  def index
    @attendees = Attendee.all
  end

  def show; end

  def new
    @attendee = Attendee.new
  end

  def edit; end

  def create
    @attendee = Attendee.create(attendee_params)

    respond_to do |format|
      if @attendee.save
        format.html { redirect_to attendee_path(@attendee), notice: 'Attendee was successfully created.' }
        format.json { render :show, status: :created, location: [@attendee, @attendee] }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @attendee.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @attendee.update(attendee_params)
        format.html { redirect_to attendee_path(@attendee), notice: 'Attendee was successfully updated.' }
        format.json { render :show, status: :ok, location: [@attendee, @attendee] }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @attendee.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @attendee.destroy
    respond_to do |format|
      format.html { redirect_to attendee_path(@attendee), notice: 'Attendee was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def attendee_params
    params.require(:attendee).permit(:name, :email)
  end

  def set_attendee
    @attendee = Attendee.find(params[:id])
  end
end
