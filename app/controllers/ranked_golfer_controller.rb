class RankedGolferController < ApplicationController
  def index

  end

  def list
    @ranked_golfers = []
    #RankedGolfer.each {|rg| @ranked_golfers << rg}
    @ranked_golfers = RankedGolfer.all.to_a
    @ranked_golfers.sort! {|a,b| a.rank <=> b.rank}
    respond_to do |format|
      format.html {render action: "index"}
      format.json {render json: @ranked_golfers}
    end
  end

  def reset
  end
end
