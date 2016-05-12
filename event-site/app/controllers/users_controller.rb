class UsersController < ApplicationController

  def show
    user = User.find(params[:id])
    @my_events = user.organized_events
  end

end
