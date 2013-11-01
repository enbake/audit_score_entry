class ClaimAuditEntry < ActiveRecord::Base

  belongs_to :reviewer, :class_name => 'Employee'#, :foreign_key => :reviewer_id
  #belongs_to :employee, :as => :reviewer
  def self.cal_exp(attrs)
    result = 0
    attrs.each do |attr|
      result += attr[1]["exception"].to_i
    end
    return "#{result} %"
  end

  def self.cal_amt(attrs)
    over = 0
    under = 0
    attrs.each do |attr|
      if attr[1]["impact"] == "Over"
        over += attr[1]["amount"].to_i
      elsif attr[1]["impact"] == "Under"
        under += attr[1]["amount"].to_i
      end
    end
    return over, under
  end

end
