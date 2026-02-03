class BookmarksController < ApplicationController
  before_action :set_list

  def new
    @bookmark = Bookmark.new
  end

  def create
    @bookmark = Bookmark.new(bookmark_params)
    @bookmark.list = @list
    if @bookmark.save
      redirect_to list_path(@list), notice: "Movie added to the list."
    else
      @bookmarks = @list.bookmarks
      render "lists/show", status: :unprocessable_entity
    end
  end

  def destroy
    @bookmark = @list.bookmarks.find(params[:id])
    @bookmark.destroy
    redirect_to list_path(@list), notice: "Bookmark removed."
  end

  private

  def set_list
    @list = List.find(params[:list_id])
  end

  def bookmark_params
    params.require(:bookmark).permit(:movie_id, :comment)
  end
end
