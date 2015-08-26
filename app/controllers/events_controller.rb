class EventsController < ApplicationController
  before_filter :authenticate_user!

  def index
    respond_with (params[:all].present? ? Event : current_user.events).includes([:user, comments: :user]).references([:user, comments: :user]).all
  end

  def create
    respond_with Event.create(filtered_params.merge(user_id: current_user.id))
  end

  def update
    event = current_user.events.find(params[:id])
    event.update_attributes(filtered_params)
    render json: Event.find(params[:id]).to_json
  end

  def destroy
    event = current_user.events.find(params[:id])
    event.destroy
    render nothing: true
  end

  def show
    respond_with Event.find(params[:id])
  end

  private

    def filtered_params
      params.require(:event).permit(:title, :starts_at, :recurs_on)
    end

end
