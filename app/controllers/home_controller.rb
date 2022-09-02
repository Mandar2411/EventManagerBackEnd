class HomeController < ApplicationController
  before_action :authorize!, only: :index
  def index
  end

  def authorize! # I believe this method is provided by devise
    unless signed_in?
      redirect_to new_user_session_path
    end
  end

  def after_registration_path
    confirmation_pending_path
  end
end
