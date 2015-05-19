class HomesController < ApplicationController
  def show
    path = current_user ? topics_path : pages_home_path
    redirect_to path
  end
end
