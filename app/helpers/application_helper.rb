module ApplicationHelper
  def clearance_discount(piece)
    if piece.condition == "good"
      return 0.90
    elsif piece.condition == "average"
      return 0.80
    else
      return 1.0
    end
  end
end
