class WikisController < ApplicationController

  def show
    @wiki = Wiki.find(params[:id])
  end

  def new
    @wiki = Wiki.new
  end

  def index
    @wikis = Wiki.all
  end

  def create
    @user = current_user
    @wiki = @user.wikis.build(wiki_params)

    if @wiki.save
      flash[:notice] = "Your wiki was created!"
      redirect_to @wiki
    else
      flash.now[:alert] = "There was an error creating your wiki."
      render :new
    end
  end

  def edit
    @wiki = Wiki.find(params[:id])
  end

  def update
    @wiki = Wiki.find(params[:id])
    @wiki.assign_attributes(wiki_params)

    if @wiki.save
      flash[:notice] = "Wiki updated"
      redirect_to @wiki
    else
      flash.now[:alert] = "The Wiki could not be updated!"
      render :edit
    end
  end


  def destroy
    @wiki = Wiki.find(params[:id])

    if @wiki.destroy
      flash[:notice] = "Wiki destroyed."
      @wikis = Wiki.all
      render :index
    else
      flash.now[:alert] = "Your Wiki could not be deleted."
      render :edit
    end

  end

  private

  def wiki_params
    params.require(:wiki).permit(:title, :body, :private)
  end

end
