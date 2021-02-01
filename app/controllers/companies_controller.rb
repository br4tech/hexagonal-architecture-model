class CompaniesController < ApplicationController
  before_action :set_company, only: [:show, :edit, :update, :destroy]

  def index
    @companies = Company.all
  end

  def new
    @company = Company.new
  end

  def edit; end

  def show
    @company = Company.find(params[:id])
  end

  def create
    @company = Company.new(company_params)
    respond_to do |format|
      if @company.save
        format.html { redirect_to @company, notice: 'Empresa cadastrado com sucesso' }
        format.json { render @company, status: :created, location: @company, message: 'Empresa cadastrado com sucesso' }
      else
        format.html { render :new }
        format.json { render json: @company.errors.full_messages, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @company.update(company_params)
        format.html { redirect_to @company, notice: 'Empresa atualizada com sucesso.' }
        format.json { render :show, status: :ok, location: @company }
      else
        format.html { render :edit }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_company
      @company = Company.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def company_params
      params.require(:company).permit(:name, :document, :wallet, :agency, :current_account, 
        :digit, :company_code, :shipping_sequence, :category, :zipcode, :city, :neighborhood, :state, :address)
    end
end
