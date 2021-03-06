class AboutsController < ApplicationController

  layout "access"
  before_action :confirm_logged_in, :except => [:index, :admin]

  def admin
    if About.count == 0
      @dept = About.new
      @site = About.new
    elsif About.count == 1
      @dept = About.first
      @site = About.new
    else
      @dept = About.first
      @site = About.second
    end
  end

  def create
    @about = About.new(about_params)
    if @about.save
      flash[:notice] = "About was updated!"
      flash[:type] = 'good'
      redirect_to(:action => 'admin')
    else
      flash[:notice] = "About was not updated!"
      flash[:type] = 'bad'
      redirect_to(:action => 'admin')
    end
  end

  def update
    @about = About.find(params[:id])
    if @about.update_attributes(about_params)
      flash[:notice] = "About was updated!"
      flash[:type] = 'good'
      redirect_to(:action => 'admin')
    else
      flash[:notice] = "About was not updated!"
      flash[:type] = 'bad'
      redirect_to(:action => 'admin')
    end
  end

  private 

    def about_params
      params.require(:about).permit(:text)
    end

end