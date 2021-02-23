# frozen_string_literal: true

class ReportsController < ApplicationController

    MONTHS = ["Janeiro", "Fevereiro", "Marco","Abril", "Maio", "Junho", "Julho", "Agosto",
    "Setembro", "Outubro", "Novembro", "Dezembro"] 

  def index
    @offices = Office.office_with_clinics   
   
    unit_id = session[:selected_office].nil? ? @offices.first.id : session[:selected_office]
  
    today = Time.now   

    @@month =  (today.month - 1) % 12
    @month = MONTHS.select.with_index { |e, i| e if i ==  @@month }.shift() + " #{today.year}"
    
    @per_unit = Office.revenue_per_unit(unit_id, @@month)
    @per_office = Clinic.revenue_per_office(unit_id, @@month)   
    
    session[:selected_month] == @@month
  end

  def reports_month 
    @offices = Office.office_with_clinics 

    unit_id = session[:selected_office].nil? ? @offices.first.id : session[:selected_office]
    @@month = session[:selected_month]
    today = Time.now
  
    if params[:type] == "prev"
      @@month=  (@@month - 1) % 12;      
    elsif params[:type] == "next"
      @@month=  (@@month + 1) % 12;     
    else
      @@month    
    end

    @month = MONTHS.select.with_index { |e, i| e if i ==  @@month }.shift() + " #{today.year}"
    @per_unit = Office.revenue_per_unit(unit_id , @@month) 
    @per_office = Clinic.revenue_per_office(unit_id , @@month) 

    session[:selected_month] = @@month

    respond_to do |format|      
      format.js
    end
  end

  def reports_category 
    @offices = Office.office_with_clinics
    unit_id = session[:selected_office].nil? ? @offices.first.id : session[:selected_office]

    if params[:tipo] == "receita"
      @per_unit = Office.revenue_per_unit(unit_id, @@month) 
      @per_office = Clinic.revenue_per_office(unit_id, @@month)
    else
      @per_unit = Office.hour_per_unit(unit_id, @@month) 
      @per_office = Clinic.hour_per_office(unit_id, @@month)
    end

    respond_to do |format|      
      format.js
    end  
  end

  def change_office_graph   
    @offices = Office.office_with_clinics  
    
    today = Time.now      
    @@month =  session[:selected_month].nil? ? (today.month - 1) % 12 : session[:selected_month];  

    @month = MONTHS.select.with_index { |e, i| e if i ==  @@month }.shift() + " #{today.year}"
      
    if params[:tipo] == "receita"
      @per_unit = Office.revenue_per_unit(params[:unit_id], @@month) 
      @per_office = Clinic.revenue_per_office(params[:unit_id], @@month)
    else
      @per_unit = Office.hour_per_unit(params[:unit_id], @@month) 
      @per_office = Clinic.hour_per_office(params[:unit_id], @@month)
    end

    session[:selected_month] = @@month
    session[:selected_office] = params[:unit_id]

    respond_to do |format|      
      format.js
    end  
  end

  def export_report_all_for_revenues
    @reports = Office.report_all_for_revenues 

    respond_to do |format|    
      format.xlsx
    end
  end

  def export_report_all_for_hours
    @reports = Office.report_all_for_hours 

    respond_to do |format|    
      format.xlsx
    end
  end

end

