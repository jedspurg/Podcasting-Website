class EpisodesController < ApplicationController
  load_and_authorize_resource

  def index
    @episodes = Episode.all
    respond_to do |format|
      format.rss do
        podcast = Podcaster.new(PODCAST_SETTINGS, @episodes)
        render :xml => podcast.to_xml
      end
      format.html do
        @episodes
      end
    end
  end

  def edit
    @episode = Episode.find(params[:id])
  end

  def new
    @episode = Episode.new
  end

  def show
    @episode = Episode.find(params[:id])
  end

  def create
    @episode = Episode.new(episode_params)
    if @episode.save
      flash[:notice] = "Episode Created"
      redirect_to episodes_path
    else
      render :action => :new
    end
  end

  def update
    @episode = Episode.find(params[:id])
    if @episode.update_attributes(episode_params)
      flash[:notice] = "Episode Updated"
      redirect_to episodes_path
    else
      render :action => :edit
    end
  end

  def destroy
    @episode = Episode.find(params[:id])
    @episode.destroy
    flash[:notice] = "Episode Deleted"
    redirect_to episodes_path
  end

  private #####################################################################

  def episode_params
    params.require(:episode).permit(:title, :author, :subtitle, :summary, :pub_date, :image, :audio)
  end

end
