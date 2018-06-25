class UpvotesController < ApplicationController
  def create
    @vote = Vote.new(vote_params.merge(user: current_user, value: 1))
    if @vote.save
      @count = Vote.where(voteable_id: params[:voteable_id], voteable_type: params[:voteable_type]).sum(:value)

      render json: {
        id: params[:voteable_id].to_i, 
        vote: @count, 
        path_up: upvotes_path(
          voteable_id: params[:voteable_id], 
          voteable_type: params[:voteable_type]
        ), 
        path_down: downvotes_path(
          voteable_id: params[:voteable_id], 
          voteable_type: params[:voteable_type]
        )
      }
    end

  end

  def update
    @vote = Vote.where(voteable_id: params[:voteable_id], voteable_type: params[:voteable_type]).first
    
    @vote.update(value: 1)
    @count = Vote.where(voteable_id: params[:voteable_id], voteable_type: params[:voteable_type]).sum(:value)
    render json: {
      id: params[:voteable_id].to_i, 
      vote: @count
    }
  end

  private
  def vote_params
    params.permit(:voteable_id, :voteable_type)
  end
end
