#require 'rubygems'
require 'mechanize'

class RankedGolferController < ApplicationController
  before_filter :authenticate_admin!, only: [:reset]
  def index

  end

  def list
    @ranked_golfers = []
    @ranked_golfers = RankedGolfer.all.to_a
    @ranked_golfers.sort! {|a,b| a.rank <=> b.rank}
    respond_to do |format|
      format.html {render action: "index"}
      format.json {render json: @ranked_golfers}
    end
  end

  def reset
    mech = Mechanize.new
    mech.get("http://sports.yahoo.com/golf/pga/stats/bycategory?season=2014&cat=WORLD_RANK") do |page|
      RankedGolfer.delete_all
      rows = page / ".sportsTable tbody tr"
      logger.debug rows.size
      rows.each do |row|
        golfer = RankedGolfer.new
        golfer.player = (row / ".player").text
        golfer.rank = (row / ".rank").text.to_i
        golfer.save
      end

    end
    redirect_to current_rankings_path, notice: "Rankings were successfully reset"
  end
end
