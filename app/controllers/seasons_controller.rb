class SeasonsController < ApplicationController
  before_filter :authenticate_user!, :only => [:comment, :mark]
  
  def show
    @season = Season.find_by_series_id_and_number(Series.find(params[:show_id]), params[:season_number])
    
    respond_to do |format|
      format.json { render :json => @season }
      format.html
    end
  end

  def comment
    if user_signed_in?
      @season = Season.find(params[:id])
      @comment = @season.comments.build(:content => params[:comment][:content],
                                 :user => current_user) 
      save_comment(@comment)
      a = current_user.activities.create!(:actor_path => user_path(current_user),
                                          :actor_img => current_user.avatar_url(:thumb),
                                          :subject => @comment,
                                          :subject_path => show_season_path(:show_id => @season.series, :season_number => @season.number, :anchor => "comment-#{@comment.id}"),
                                          :kind => "comment",
                                          :data => { "content" => @comment.content,
                                                    "commented_name" => @comment.commentable.full_name,
                                                    "commented_path" => show_season_path(:show_id => @season.series, :season_number => @season.number) }.to_json)
    end
  end
  
  def get_poster
    @season = Season.find(params[:id])
    respond_to do |format|
      format.js do
        if @season.poster_processing?
          render :nothing => true, :status => 403
        else
          if params[:size] == "small"
            render :partial => "poster_small", :locals => { :season => @season }
          else
            render :partial => "poster", :locals => { :season => @season }
          end
        end
      end
      format.html { redirect_to show_path(@season) } # redirect to show
    end
  end
  
  def mark
    season = Season.find(params[:id])
    current_user.episodes_seen << season.episodes
    respond_to do |format|
      format.js { render :partial => "shows/season_my", :locals => { :season => season } }
      format.html { redirect_to show_path(season.series) }
    end
  end
end
