require 'csv'
class PiecesController < ApplicationController

  def list
    @pieces = fetch_pieces
  end

  def detail
    @pieces =fetch_pieces
    @piece = @pieces.find {|p| p.pid.to_i == params[:pid].to_i}
  end

  def fetch_pieces
    @pieces = []

    CSV.foreach(Rails.root + "data/mf_inventory.csv", headers: true) do |row|
      # fill the array
      piece = Piece.new
      piece.pid = row.to_h["pid"]
      piece.item = row.to_h["item"]
      piece.description = row.to_h["description"]
      piece.price = row.to_h["price"]
      piece.condition = row.to_h["condition"]
      piece.dimension_w = row.to_h["dimension_w"]
      piece.dimension_l = row.to_h["dimension_l"]
      piece.dimension_h = row.to_h["dimension_h"]
      piece.img_file = row.to_h["img_file"]
      piece.quantity = row.to_h["quantity"]
      piece.category = row.to_h["category"]


      @pieces << piece

    end
    @pieces
  end

  def clearance_discount(condition)
    @pieces.each do |piece|
      if piece.condition == "good"
        return 0.90
      elsif piece.condition == "average"
        return 0.80
      end
    end
  end
end
