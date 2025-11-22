class ListsController < ApplicationController
  before_action :set_list, only: [:show, :destroy]

  def index
    @lists = List.includes(:bookmarks, photo_attachment: :blob).order(created_at: :desc)
  end

   def show
    @bookmarks = @list.bookmarks.includes(:movie).order(created_at: :desc)
    @bookmark = Bookmark.new
  end

  def new
    @list = List.new
  end

  def create
    @list = List.new(list_params)
    if @list.save
      redirect_to @list, notice: "Liste créée avec succès."
    else
      flash.now[:alert] = @list.errors.full_messages.to_sentence
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @list = List.find(params[:id])
  end

  def update
      @list = List.find(params[:id])
    if @list.update(list_params)
      redirect_to @list, notice: "Liste mise à jour avec succès"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @list.photo.purge if @list.photo.attached?
    @list.destroy
    redirect_to lists_path, notice: "Liste supprimée.", status: :see_other
  end

  private

  def set_list
    @list = List.find(params[:id])
  end

  def list_params
    params.require(:list).permit(:name, :photo)
  end
end
