class My::ShowsController < ApplicationController
  before_filter :authenticate_user!
  
  def index
    @shows = current_user.series.order("name ASC") if current_user
  end
  
  def show
    @show = Series.find(params[:id])
    @unseen_episodes = @show.episodes.available.unseen_by(current_user)
    @next_episode = @show.next_episode
  end
end
