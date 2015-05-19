class BookmarksController < ApplicationController
  before_action :set_bookmark, only: [:show, :edit, :update, :destroy]
  before_action :set_topic

  respond_to :html, except: [:destroy]

  def index
    @bookmarks = @topic.bookmarks.all
    respond_with(@bookmarks)
  end

  def show
    respond_with(@bookmark)
  end

  def new
    @bookmark = Bookmark.new
    respond_with(@bookmark)
  end

  def edit
  end

  def create
    @bookmark = current_user.bookmarks.build(bookmark_params)
    @bookmark.topic = @topic
    if @bookmark.save
      # Tell the user it saved
    else
      # Tell the user there was an error
    end
    respond_with(@topic, @bookmark)
  end

  def update
    @bookmark.update(bookmark_params)
    respond_with(@topic, @bookmark)
  end

  def destroy
    @bookmark.destroy
    respond_to do |format|
      # TODO: I'm following the pattern I've seen elsewhere, but I don't actually know why there needs to be an html format listed here if we're not using it...
      format.html
      format.js
    end
  end

  private
    def set_bookmark
      @bookmark = Bookmark.find(params[:id])
    end

    def set_topic
      @topic = Topic.find(params[:topic_id])
    end

    def bookmark_params
      params.require(:bookmark).permit(:url, :name, :user_id, :topic_id)
    end
end
