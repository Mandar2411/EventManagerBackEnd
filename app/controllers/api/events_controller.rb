class Api::EventsController < ApplicationController
    def events
        event_type = params[:event_type]
        event_status = params[:status]
        tag_list = params[:tags] || ""
        
        tag_list = tag_list.strip.split(',')
        
        if tag_list.size == 0
          if event_type == 'All'
            if event_status == "Upcoming"
              @events = Event.where("end_date > ?", Date.current)
              render json: @events
            else 
              @events = Event.where("end_date < ?", Date.current)
              render json: @events
            end
          else
            if event_status == "Upcoming"
              @events = Event.where("end_date > ? AND event_type = ?", Date.current, event_type)
              render json: @events
            else 
              @events = Event.where("end_date < ? AND event_type = ?", Date.current, event_type)
              render json: @events
            end
          end
        else 
          if event_type == 'All'
            if event_status == "Upcoming"
              @events = Event.where("end_date > ?", Date.current).joins(taggings: :tag).where(tag: {id: tag_list})
              render json: @events.uniq
            else 
              @events = Event.where("end_date < ?", Date.current).joins(taggings: :tag).where(tag: {id: tag_list})
              render json: @events.uniq
            end
          else
            if event_status == "Upcoming"
              @events = Event.where("end_date > ? AND event_type = ?", Date.current, event_type).joins(taggings: :tag).where(tag: {id: tag_list})
              render json: @events.uniq
            else 
              @events = Event.where("end_date < ? AND event_type = ?", Date.current, event_type).joins(taggings: :tag).where(tag: {id: tag_list})
              render json: @events.uniq
            end
          end
        end
    end

    def event
        @event = Event.find(params[:id])
        if(@event.reg_start_date>Date.current)
          render json: {event: @event, message:"Registrations available soon"}
        elsif(@event.reg_end_date<Date.current)
          render json: {event: @event, message:"Registrations Closed"}
        else  
          render json: {event: @event, message:"register"}
        end
    end

    def taggings
        @taggings = Tagging.all
        render json: @taggings
    end

    def tags
        @tags = Tag.all.pluck(:id, :name).to_h
        render json: @tags
    end

    def tagids
      @tagids = Tag.all.pluck(:id)
      render json: @tagids
    end
end
