class PagesController < ApplicationController

  def home
    @rooms = Room.where(active: true).limit(3)
  end

  def search
    #Step 1 - assign session here
    if params[:search].present?
      #Create session
      session[:loc_search] = params[:search]
    end

    #Step 2
    if session[:loc_search]
      #Grab all cities and nearby cities
      @rooms_address = Room.where(active: true).near(session[:loc_search], 5, order: 'distance')
    else
      #Grab all places here
      @rooms_address = Room.where(active: true).all
    end

    #Step 3 - For ransack usage
    @search = @rooms_address.ransack(params[:q])
    @rooms = @search.result
    @arrRooms = @rooms.to_a

    #Step 4
    if (!params[:start_date].empty? && !params[:end_date].empty?)
      @start_date = Date.parse(params[:start_date])
      @end_date = Date.parse(params[:end_date])
      @rooms.each do |room|
        taken_room = room.reservations.where("? <= start_date AND start_date <=? OR (? <= end_date AND end_date <= ? )",
        @start_date, @end_date,
        @start_date, @end_date).limit(1)

        #ここでdeleteしてroom2とかroom3にループする
        if taken_room.any?
          @arrRooms.delete(room)
        end
      end
    end
  end
end
