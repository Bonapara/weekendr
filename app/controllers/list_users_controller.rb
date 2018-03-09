class ListUsersController < ApplicationController

  def create
    email = params[:list_user][:user]
    other_user = User.find_by(email: email)
    bookmark = Bookmark.find(params[:bookmark_id])
    weekend = bookmark.weekend
    bookmark_other_user = Bookmark.new
    bookmark_other_user.weekend = weekend
    bookmark_other_user.user = other_user
    bookmark_other_user.save
    # list_user = ListUser.new
    # list_user.user = other_user
    # list_user.bookmark = bookmark
    # list_user.save
    # redirect_to bookmarks_path
    # require 'pry-byebug'
    # binding.pry

    # expéditeur : current_user
    # bookmark > params
    # destinataire > params depuis la form
    # ListUser.new
    # @list_user.destinataire = ...
    # if .save
    #   send mail...
    # redirect_to
    # else
    #   fail path
    # end

    redirect_to bookmarks_path
  end

end
