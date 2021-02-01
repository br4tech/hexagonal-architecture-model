
class ReportService
  attr_reader :params
  attr_accessor :report

  def initialize(params)
    @params = params 
  end

  def report_all
     offices = Office.report_all
  end
end
