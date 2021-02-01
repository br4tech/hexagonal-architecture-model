class ReprocessPayrollWorker
include Sidekiq::Worker

def perform(reprocess_month)
  contracts = Contract.all
  contracts.each do |contract| 
    contract.attendances.each  do |attendance|                   

      starts_at =  attendance.starts_at.prev_month.beginning_of_month.to_date
      ends_at = attendance.ends_at.to_date

      payroll_groups = (starts_at..ends_at).to_a.in_groups_of(30)
      payroll_groups = payroll_groups.each &:compact!

      payroll_groups.each do |group| 
        
        if group.first.month == group.last.month  &&   group.first.year != group.last.year     
          month = group.first.month - 1        
        else
          month = group.first.month
        end

        first = Date.new(group.first.year, month, 21)
        last = Date.new(group.last.year, group.last.month, 20)

        if group.last.month == reprocess_month                                      
          payroll = Payroll.find_or_create_by(
            emission: last.beginning_of_month, 
            due_at:  last.beginning_of_month, 
            revenues_at:  first,
            contract_id: contract.id, 
            starts_at: first, 
            parking_value: contract.parking_value,
            ends_at: last)

          PayrollItem.delete_by(payroll_id: payroll.id)

          reservations_one = Reservation.select("id, clinic_id, date, start_at, end_at, odd")
            .where("contract_id= #{contract.id} AND odd = false AND date BETWEEN ? AND ?", first, last) 

          reservations_two= Reservation.select("id, clinic_id, date, start_at, end_at, odd")
            .where("contract_id= #{contract.id} AND odd = true AND date < ?", payroll.due_at)
            
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
