module CallAuditListHelper

  def css_find(css_id)
    if !css_id.blank?
      css=Employee.where(:id=>css_id.to_i).first
      if !css.blank?
        return "#{css.first_name} "+"#{css.last_name}"
      end 
    end
  end
  def employee_find(employee_id)
    if !employee_id.blank?
      emp=Employee.where(:id=>employee_id.to_i).first
      if !emp.blank?
        return "#{emp.first_name} "+"#{emp.last_name}"
      end	
    end
  end

  def get_date(year,month,day)
  	Date.new(year.to_i,month.to_i,day.to_i)
  end	
end
