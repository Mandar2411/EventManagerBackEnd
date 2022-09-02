class EventsController < ApplicationController
    

    def index
      @events = Event.all
      @tags = Tag.all
    end
  
    def show 
      @event = Event.find(params[:id])
      @registered_users = Registration.where('event_id = ?', params[:id])
      @users = User.all
    end
  
    def new
      @event = Event.new
    end
  
    def create
      @event = Event.new(event_params.except(:tags))
      create_or_delete_events_tags(@event, params[:event][:tags])
      if @event.save
        redirect_to @event
      else
        render :new, status: :unprocessable_entity
      end
    end
  
    def edit
      @event = Event.find(params[:id])
    end
  
    def update
      @event = Event.find(params[:id])
      create_or_delete_events_tags(@event, params[:event][:tags])
      if @event.update(event_params.except(:tags))
        redirect_to @event
      else
        render :edit, status: :unprocessable_entity
      end
    end
  
    def destroy
      @event = Event.find(params[:id])
      @event.destroy
  
      redirect_to root_path, status: :see_other
    end

    def register
      @event = Event.find(params[:id])
      @user = current_user
      
      r = Registration.find_by(event_id: @event.id, user_id: @user.id)
      if r 
        r.delete
      else 
        r = Registration.new
        r.event_id = @event.id
        r.user_id = @user.id
        r.save
      end
      redirect_to @event
    end

    private
  
    def create_or_delete_events_tags(event, tags)
      event.taggings.destroy_all
      tags = tags.delete(' ')
      tags = tags.strip.split(',')
      tags.each do |tag|
        event.tags << Tag.find_or_create_by(name: tag.upcase)
      end
    end
  
    def event_params
      params.require(:event).permit(:title, :description, :venue, :event_type, :start_date, :end_date, :reg_start_date, :reg_end_date, :fee, :image_url, :tags)
    end
  end
  