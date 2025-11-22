class BookmarksController < ApplicationController
  before_action :set_list, only: [:new, :create]
  before_action :set_bookmark, only: [:edit, :update, :destroy]

  def new
    @bookmark = @list.bookmarks.new
  end

  def create
    @bookmark = @list.bookmarks.new(bookmark_params)
    @bookmark.list = @list
    if @bookmark.save
      redirect_to @list, notice: "Signet ajouté."
    else
      flash.now[:alert] = @bookmark.errors.full_messages.to_sentence
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @bookmark.update(bookmark_params)
      redirect_to @bookmark.list, notice: "Signet mis à jour."
    else
      flash.now[:alert] = @bookmark.errors.full_messages.to_sentence
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    list = @bookmark.list
    @bookmark.destroy
    redirect_to list, notice: "Signet supprimé.", status: :see_other
  end

  private

  def set_list
    @list = List.find(params[:list_id])
  end

  def set_bookmark
    @bookmark = Bookmark.find(params[:id])
  end

  def bookmark_params
    params.require(:bookmark).permit(:movie_id, :comment)
  end
end

