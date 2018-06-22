class VotesController < ApplicationController
  def create
    @vote = Vote.new(vote_params.merge(user: current_user))
    if @vote.save
      @count = Vote.where(voteable_id: params[:voteable_id], voteable_type: params[:voteable_type]).sum(:value)
      
      render json: {id: params[:voteable_id].to_i, vote: @count, path_up: votes_path(voteable_id: params[:voteable_id], voteable_type: params[:voteable_type],value: 1), 
        path_down: votes_path(voteable_id: params[:voteable_id], voteable_type: params[:voteable_type], value: -1)}
    end
    
  end
  
  def update
    @vote = Vote.where(voteable_id: params[:voteable_id], voteable_type: params[:voteable_type]).first
    @vote.update_column(:value, params[:value])
    @count = Vote.where(voteable_id: params[:voteable_id], voteable_type: params[:voteable_type]).sum(:value)
    render json: {id: params[:voteable_id].to_i, vote: @count}
  end
  
  private
  def vote_params
    params.permit(:voteable_id, :voteable_type, :value)
  end
end
