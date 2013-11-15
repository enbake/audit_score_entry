module ClaimAuditEntriesHelper

  def select_range(question)
    if question.category == "Admin" || question.category == "Compliance"
      if question.min_exception and question.max_exception
        return question.min_exception.to_i..question.max_exception.to_i
      else
        1..30
      end
    elsif question.category == "Estimation Decisions"
      return question.min_amount
    end
  end

end
