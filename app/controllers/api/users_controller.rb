class Api::UsersController < ApplicationController
    require "jwt"
    SECRET_KEY = Rails.application.secret_key_base
    
    def jwt_encode(payload, exp=7.days.from_now)
        payload[:exp] = exp.to_i
        JWT.encode(payload, SECRET_KEY)
    end

    def jwt_decode(token)
        decoded = JWT.decode(token, SECRET_KEY)[0]
        HashWithIndifferentAccess.new decoded
    end

    def register
        @user = User.create(user_params)
        if @user.save
            response = { message: 'User created successfully', id: @user.id}
            render json: response, status: :created 
        else
            render json: @user.errors, status: :bad
        end 
    end

    def login
        user = User.find_by_email(user_params[:email])
        if user && user.valid_password?(user_params[:password])
            token = jwt_encode(user_id: user.id)
            decoded = jwt_decode(token)
            response = { token: token, decoded: decoded[:user_id], message: 'User found successfully'}
            render json: response
        else
            render json: { errors: { 'email or password' => ['is invalid'] } }, status: :unprocessable_entity
        end
    end

    def checkregister
        event_id = params[:id]
        token = params[:token]
        user_id = jwt_decode(token)[:user_id]
        present = Registration.find_by(event_id: event_id, user_id: user_id)
        
        if present
            response = { present: "true" }
            render json: response
        else 
            response = { present: "false" }
            render json: response
        end 
    end

    def eventregister
        event_id = params[:id]
        token = params[:token]
        user_id = jwt_decode(token)[:user_id]
        @registration = Registration.create(event_id: event_id.to_i, user_id: user_id)
        @registration.save
        render json: "true"
    end

    def eventunregister
        event_id = params[:id]
        token = params[:token]
        user_id = jwt_decode(token)[:user_id]
        @registration = Registration.where('event_id = ? and user_id = ?', event_id.to_i, user_id).first
        @registration.destroy
        render json: "true"
    end

    def getid
        token = params[:token]
        user_id = jwt_decode(token)[:user_id]
        render json: user_id
    end

    def getuser
        id = params[:id]
        @user = User.find(id)
        @registrations = Registration.where('user_id = ?', id.to_i).pluck(:event_id)
        @events = Event.all.pluck(:id, :title).to_h
        render json: {'user': @user, 'registrations': @registrations, 'events': @events}
    end
    
    private
    
    def user_params
        params.permit(
          :email,
          :password
        )
    end
end
