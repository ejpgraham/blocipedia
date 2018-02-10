class WikisController < ApplicationController
  include Pundit
  after_action :verify_authorized, except: [:index]

  def show
    @wiki = Wiki.find(params[:id])
    authorize @wiki
  end

  def new
    @wiki = Wiki.new
    authorize @wiki
  end

  def index
    @wikis = policy_scope(Wiki)
  end

  def create
    @user = current_user
    @wiki = Wiki.new(wiki_params)
    @wiki.user = @user
    authorize @wiki


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
    authorize @wiki
  end

  def update
    @wiki = Wiki.find(params[:id])
    authorize @wiki
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
    authorize @wiki

    if @wiki.destroy
      flash[:notice] = "Wiki destroyed."
      redirect_to wikis_path
    else
      flash.now[:alert] = "Your Wiki could not be deleted."
      render :edit
    end

  end

  private

  def wiki_params
    params.require(:wiki).permit(:title, :body, :private, user_ids:[])
  end

end
