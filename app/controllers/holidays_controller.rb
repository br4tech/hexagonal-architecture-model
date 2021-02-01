class HolidaysController < ApplicationController
  before_action :set_holiday, only: [:show, :edit, :update, :destroy]

  def index
    @holidays = Holiday.page(params[:page]).per(7)
  end

  def show
    @holiday = Holiday.find(params[:id])
  end

  def new
     @holiday = Holiday.new
  end

  def edit; end

  def create
    @holiday = Holiday.new(holiday_params)
    respond_to do |format|
      if @holiday.save
        format.html { redirect_to @holiday , notice: 'Feriado cadastrado com sucesso' }
        format.json { render@holiday , status: :created, location: @holiday , message: 'Feriadoa cadastrado com sucesso' }
      else
        format.html { render :new }
        format.json { render json: @holiday .errors.full_messages, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @holiday.update(holiday_params)
        format.html { redirect_to @holiday, notice: 'Feriado atualizada com sucesso.' }
        format.json { render :show, status: :ok, location: @company }
      else
        format.html { render :edit }
        format.json { render json:@holiday.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @holiday.destroy
    respond_to do |format|	    
      format.html { redirect_to  @holiday, notice: 'Feriado removido.' }	 
      format.json { head :no_content }	
    end
  end

  def days_off
    @days_off = DayOff.all       
  end

  private

  def set_holiday
    @holiday = Holiday.find(params[:id])
  end

  def holiday_params
    params.require(:holiday).permit(:id, :name, :color, :starts_at, :ends_at)
  end

end
