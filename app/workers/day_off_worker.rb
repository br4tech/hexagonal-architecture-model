class DayOffWorker
  include Sidekiq::Worker

  def perform(*args)
    DayOff.destroy_all

    Holiday.all.each do | holiday |
      start_at = holiday.starts_at.to_date
      end_at = holiday.ends_at.to_date

      day_offs = (start_at..end_at).to_a    
    
      day_offs.each do |day_off|
        DayOff.find_or_create_by(
          date: day_off, 
          holiday_id: holiday.id,
          color: holiday.color,
          description: holiday.name
        )
      end
    end

    p "Feriado(s) gerado com sucesso!"
  end
end