class Users::UsersController < ApplicationController
    def index
        @users = User.all
        @userroles = Userrole.all
    end

    def show
        @user = User.find(params[:id])
        @registered_events = Registration.where('user_id = ?', params[:id])
        @events = Event.all
        @userroles = Userrole.all
    end
end
