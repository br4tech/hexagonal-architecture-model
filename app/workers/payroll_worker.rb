class PayrollWorker
  include Sidekiq::Worker

  def perform()
    contracts = Contract.includes(:attendances).all
    contracts.each do |contract|
      contract.attendances.each  do |attendance|
        starts_at = attendance.starts_at.prev_month.beginning_of_month.to_date
        ends_at = attendance.ends_at.to_date

        payroll_groups = (starts_at..ends_at).to_a.in_groups_of(30)
        payroll_groups = payroll_groups.each(&:compact!)
        payroll_groups.each do |group|
          month = if group.first.month == group.last.month && group.first.year != group.last.year
                    group.first.month - 1
                  else
                    group.first.month
                  end

          first = Date.new(group.first.year, month, 21)
          last = Date.new(group.last.year, group.last.month, 20)               

          payroll = Payroll.where(
            emission: last.beginning_of_month,
            due_at: last.beginning_of_month,
            revenues_at: first,
            contract_id: contract.id,
            starts_at: first,
            ends_at: last
          ).first

          PayrollItem.delete_by(payroll_id: payroll.id) unless payroll.nil?

          payroll.delete if !payroll.nil? && payroll.parking_value != contract.parking_value

          payroll = Payroll.create(
            emission: last.beginning_of_month,
            due_at: last.beginning_of_month,
            revenues_at: first,
            contract_id: contract.id,
            starts_at: first,
            ends_at: last,
            parking_value: contract.parking_value
          ) if payroll.nil?

          reservations_one = Reservation.select("id, clinic_id, date, start_at, end_at, odd")
            .where("contract_id= #{contract.id} AND odd = false AND date BETWEEN ? AND ?", first, last) 

          reservations_two= Reservation.select("id, clinic_id, date, start_at, end_at, odd")
            .where("contract_id= #{contract.id} AND odd = true AND date > ? AND date < ?", payroll.due_at - 1.month, payroll.revenues_at)
            
           reservations = reservations_one.or(reservations_two)
              
          reservations.each do |reserve|    
            hours = time_diff(reserve.start_at, reserve.end_at)    
            amount = amount_for_kind_contract(contract, reserve, first, last, hours)            
        
            PayrollItem.find_or_create_by(
            period: reserve.date,
            clinic_id: reserve.clinic_id,
            hours: hours, 
            amount: amount,
            payroll_id: payroll.id,
            odd: reserve.odd,
            reservations_id: reserve.id)                              
          end          
        end
      end   
    end  

    p "Boleto(s) gerado com sucesso!"
  end




  def time_diff(start_at, end_at)
    (start_at - end_at).to_i.abs / 3600     
  end

  def amount_for_kind_contract(contract, reserve, first, last, hours) 
    amount = 0
    case contract.kind
    when 0..1    
      unless contract.discounts.empty?  
        contract.discounts.each do |d|  
          unless d.starts_at.nil? && d.ends_at.nil?    
            if reserve.start_at >=   d.starts_at  && reserve.end_at <= d.ends_at       
              amount = contract.amount * hours - (contract.amount * hours) * (d.amount/100)
            else
              amount = contract.amount * hours
            end
          else
            amount = contract.amount * hours      
          end
        end
      else
        amount = contract.amount * hours
      end      
    when 2  
      unless contract.discounts.empty?  
        contract.discounts.each do |d|
          unless d.starts_at.nil? && d.ends_at.nil?
            months =  (d.starts_at.month..d.ends_at.month).map{ |m| m}.uniq
            if  months.include?(reserve.start_at.month)
              amount = (contract.amount - contract.amount * (d.amount/100))
            else
              amount = contract.amount 
            end
          else
            amount = contract.amount 
          end
        end
      else
        amount = contract.amount
      end        
    end

    amount
  end   
end
