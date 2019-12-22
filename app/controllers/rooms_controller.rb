class RoomsController < ApplicationController

  before_action :set_room, except: [:index, :new, :create]
  before_action :authenticate_user!, except: [:show]

  def index
    @rooms = current_user.rooms
  end

  def new
    @room = current_user.rooms.build
  end

# notice:はredirect＿to のみ使う
# renderはflashを使う
  def create
    @room = current_user.rooms.build(room_params)
    if @room.save
      redirect_to listing_room_path(@room), notice: "Saved..."
    else
      flash[:alert] = "Something went wrong..."
      render :new
    end
  end

  def show
    @photos = @room.photos
    @reservation = Reservation.new
    @guest_reviews = @room.guest_reviews
  end

  def listing
  end

  def pricing
  end

  def description
  end

  def photo_upload
    @photos = @room.photos
  end

  def amenities
  end

  def location
  end

  def update
    if @room.update(room_params)
      flash[:notice] = "Saved..."
    else
      flash[:alert] = "Something went wrong..."
    end
      # 同じ場所に移動する
      redirect_back(fallback_location: request.referer)
  end

  #Reservation
  def preload
    reservations = @room.reservations
    render json: reservations
  end

  def  preview
    start_date = Date.parse(params[:start_date])
    end_date = Date.parse(params[:end_date])

    output = {
      conflict: is_conflict(start_date, end_date, @room)
    }

    render json: output
  end

  private

    def is_conflict(start_date, end_date, room)
      check = room.reservations.where("? < start_date AND end_date < ?", start_date, end_date)
      check.size > 0 ? true : false
      # if check.size > 0
      #   true
      #   else
      #   false
      # end
    end

    def set_room
      @room = Room.find(params[:id])
    end

    def room_params
      params.require(:room).permit(:home_type, :room_type, :accommodate, :bedroom, :bathroom, :listing_name, :summary, :address, :is_tv, :is_kitchen, :is_air, :is_heating, :is_internet, :price, :active )
    end
end
