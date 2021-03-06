class MissionsController < ApplicationController
  
  MissionOver = Class.new(StandardError)
  
  rescue_from MissionOver do
    redirect_to @mission, :alert => tf('mission.over')
  end
  
  rescue_from Mission::SignupClosed do
    redirect_to @mission, :alert => tf('mission.signup_closed')
  end
  
  before_filter :prepare_mission,        :except => [:next, :index]
  before_filter :require_user_with_note, :only   => [:edit, :update]
  before_filter :require_valid_user,     :only   => [:edit, :update]
  before_filter :prepare_participation,  :only   => [:edit, :update]
  
  def show
    @mission_questions = Question.for(:mission_page).all
  end
  
  def join
    @captain_questions  = Question.for(:captain_section).all
    @sidekick_questions = Question.for(:sidekick_section).all
  end
  
  def edit
    check_mission_status!
    return redirect_to([:join, @mission]) if @participation.role.blank?
  end
  
  def update
    check_mission_status!
    if @participation.update_attributes(params[:mission_participation])
      flash[:recently_joined_mission] = @participation.recently_joined?
      redirect_to @mission, :notice => tf('participation.joined')
    else
      @requires_details = true
      render :action => "edit"
    end
  end

  def index
    @missions = Mission.completed.all
  end
  
  protected
  
  def prepare_mission
    return redirect_next_mission if params[:id] == "next" && request.get?
    @mission = Mission.viewable.optimize_viewable.find_using_slug!(params[:id])
    if @mission.has_better_slug?
      redirect_to mission_path(@mission), :status => :moved_permanently
      return false
    end
    add_title_variables! :mission => @mission.name
  end
  
  def prepare_participation
    @participation = @mission.participation_for(current_user, params[:as])
  end
  
  def redirect_next_mission
    mission = Mission.viewable.next.first
    raise ActiveRecord::RecordNotFound if mission.blank?
    url = case params[:action]
    when "join", "edit"
      [params[:action].to_sym, mission]
    else
      mission
    end
    redirect_to url
  end
  
  def check_mission_status!
    raise MissionOver unless @participation.still_preparing?(true) && @mission.unstarted?
  end
  
  def require_user_with_note
    unless logged_in?
      store_location
      flash[:joining_mission] = true
      redirect_to new_user_path
      return false
    end
  end
  
  def require_valid_user
    if logged_in? && !current_user.valid?
      store_location
      redirect_to edit_user_path(:current), :alert => tf('profile.invalid')
      return false
    end
  end
  
  def logged_in_and_signed_up_to_mission?
    @mission.participating?(current_user) && !@mission.participation_for(current_user).still_preparing?
  end
  
end
