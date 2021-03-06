class VenuesController < ApplicationController
  helper VotesHelper

  before_action :authenticate_user!, only: [
                                             :new,
                                             :create,
                                             :edit,
                                             :update,
                                             :destroy
                                           ]
  before_action :check_permissions, only: [:edit, :update, :destroy]

  def index
    @venues = Venue.search(params[:query])
  end

  def show
    @venue = Venue.find(params[:id])
    @reviews = Review.where("venue_id = ?", params[:id])
  end

  def new
    @venue = Venue.new
  end

  def create
    @venue = Venue.new(venue_params)
    @venue.user = current_user
    if @venue.save
      flash[:success] = 'Venue saved successfully'
      redirect_to venue_path(@venue)
    else
      flash[:alert] = 'Problems saving venue'
      @errors = @venue.errors.full_messages
      render 'venues/new'
    end
  end

  def edit
    @venue = Venue.find(params[:id])
  end

  def update
    @venue = Venue.find(params[:id])
    if @venue.update(venue_params)
      flash[:success] = 'Venue saved successfully'
      redirect_to venue_path(@venue)
    else
      flash[:alert] = 'Problems updating venue'
      @errors = @venue.errors.full_messages
      render 'venues/edit'
    end
  end

  def destroy
    @venue = Venue.find(params[:id])
    if @venue.destroy
      flash[:success] = 'Venue deleted successfully'
      redirect_to venues_path
    else
      flash[:alert] = 'Problems deleting venue'
      redirect_to venue_path(@venue)
    end
  end

  private

  def venue_params
    params.require(:venue).permit(:name,
                                  :address,
                                  :website,
                                  :capacity,
                                  :t_accessible)
  end
end
