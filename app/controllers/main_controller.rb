# frozen_string_literal: true

# Main Controller
class MainController < ApplicationController  

  def index   
    @offices = current_user.offices
    
    unless @offices.empty?
      @office = params[:office_id].nil? ? @offices.first :  params[:office_id] 
      @clinics = params[:office_id].nil? ? Clinic.where(office_id: @office.id) : params[:office_id]  
    else
      @clinics = []
      flash[:alert] = "Usuário sem unidade"
    end 
  end

  def change_office_schedule	 
    session[:office_id] =  params[:id]	
    @clinics =  Clinic.where(office_id: params[:id]) 
    respond_to do |format|	
      format.js	
    end	
  end
end
