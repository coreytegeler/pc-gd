class AlumniController < ApplicationController

  layout_by_action "access", [:index] => "public"
  before_action :confirm_logged_in, :except => [:index, :admin]

  def index
    @alumni = Alumnus.first_to_last
  end

  def admin
    @alumni = Alumnus.last_to_first
    @new_alumnus = Alumnus.new
    @new_alumnus.position = Alumnus.count + 1
  end

  def create
    @alumnus = Alumnus.new(alumnus_params)
    if @alumnus.save
      update_positions
      flash[:notice] = "Alumnus was created!"
      flash[:type] = 'good'
      redirect_to(:action => 'admin')
    else
      flash[:notice] = "Alumnus was not created!"
      p @alumnus.errors.full_messages
      flash[:type] = 'bad'
      redirect_to(:action => 'admin')
      @new_alumnus = Alumnus.new
      @new_alumnus.position = Alumnus.all.count + 1
    end
  end

  def update
    @alumnus = Alumnus.find(params[:id])
    if @alumnus.update_attributes(alumnus_params)
      update_positions
      flash[:notice] = "Alumnus was updated!"
      flash[:type] = 'good'
      redirect_to(:action => 'admin')
    else
      flash[:notice] = "Alumnus was not updated!"
      flash[:type] = 'bad'
      redirect_to(:action => 'admin')
      @new_alumnus = Alumnus.new
      @new_alumnus.position = Alumnus.all.count + 1
    end
  end

  def delete
    @alumnus = Alumnus.find(params[:id])
    respond_to do |format|
      format.js { render partial: 'delete', :locals => {:alumnus => @alumnus} }
    end
  end

  def destroy
    @alumnus = Alumnus.find(params[:id]).destroy
    update_positions
    flash[:notice] = "Alumnus was deleted!"
    flash[:type] = 'good'
    redirect_to(:action => 'admin')
  end

  private 

    def alumnus_params
      params.require(:alumnus).permit(:name, :first_name, :last_name, :url, :position, :id)
    end

    def update_positions
      Alumnus.first_to_last.each_with_index do |f, i|
          f.update_attribute(:position, i+1)
      end
    end

end