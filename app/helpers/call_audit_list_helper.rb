module CallAuditListHelper

  def css_find(css_id)
    if !css_id.blank?
      css=Employee.where(:id=>css_id.to_i).first
      if !css.blank?
        return "#{css.first_name} "+"#{css.last_name}"
      end	
    end
  end

end
