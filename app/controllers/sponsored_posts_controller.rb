class SponsoredPostsController < ApplicationController
  before_action :find_sponsored_post,
                only: [:show, :edit, :update, :destroy]

  def show
  end

  def new
    @sponsored_post = SponsoredPost.new
  end

  def edit
  end

  private

  def find_sponsored_post
    @sponsored_post = SponsoredPost.find(params[:id])
  end
end
