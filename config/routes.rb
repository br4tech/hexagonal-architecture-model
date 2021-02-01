# frozen_string_literal: true
require 'sidekiq/web'
Rails.application.routes.draw do 

  mount Sidekiq::Web => '/sidekiq'
  devise_for :users, path: '', path_names: { sign_in: 'entrar', sign_out: 'sair' }

  scope(path_names: { new: 'cadastro', edit: 'edicao' }) do
    resources :offices, path: 'unidades' do
      resources :clinics, path: 'salas'
    end  
    resources :companies, path: 'empresas'
    resources :contracts, path: 'contratos'
    resources :reports, path: 'relatorios'
    get :reports_month, to: 'reports#reports_month'
    get :reports_category, to: 'reports#reports_category' 
    get :change_office_graph, path: 'change_office_graph/:unit_id', to: 'reports#change_office_graph'
   
    resources :doctors, path: 'medicos';

    resources :clients, path: 'clientes' do
      get 'contratos' => 'clients#contracts', on: :member, as: :contracts
      get 'contratos/:combo_id/informacoes' => 'clients#info', on: :member, as: :info
      get 'contratos/:combo_id/:category' => 'clients#combo', on: :member, as: :combo     
      get 'search', on: :collection
    end

    resources :payrolls, path: 'financeiro'
    resources :expertises, path: 'especialidades', only: [:index]
    resources :users, path: 'usuarios' do
      patch 'safe', to: 'users#update_password', on: :collection
    end  
  end

  get 'perfil' => 'users#profile', as: :profile

  get :payroll_month, to: 'payrolls#payroll_month'
  get :payroll_category , to: 'payrolls#payroll_category'   
  post :export_payroll, to: 'payrolls#export_payroll'
  get :reprocess_payroll , to: 'payrolls#reprocess_payroll'   

  get :office_schedule, path: 'office_schedule/:id', to: 'offices#office_schedule' 
  get :change_office_schedule, path:'change_office_schedule/:id', to: 'main#change_office_schedule'
  get :clinic_attendances, path: 'clinic_attendances/:office_id/:id', to: 'clinics#clinic_attendances'
  post :find_address, path: 'find_address' ,to: 'doctor#find_address'
  post :reservation_not_available, to: 'reservations#reservation_not_available'
  post :reservation_not_available_day, to: 'reservations#reservation_not_available_day'
  resources :reservations
  resources :holidays
  resources :reservation_without_contracts
  get :days_off, path: 'days_off', to: 'holidays#days_off'
  get :export_report_all_for_revenues, to: 'reports#export_report_all_for_revenues'
  get :export_report_all_for_hours, to: 'reports#export_report_all_for_hours'
  root to: 'main#index'
 
end
