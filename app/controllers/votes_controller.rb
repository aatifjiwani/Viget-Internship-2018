class VotesController < ApplicationController
  def create
    @vote = Vote.new(vote_params.merge(user: current_user))
    if @vote.save
      @count = Vote.where(article_id: params[:article_id]).sum(:value)
      render json: {id: params[:article_id].to_i, vote: @count, path_up: votes_path(article_id: params[:article_id], value: 1), 
        path_down: votes_path(article_id: params[:article_id], value: 1)}
    end
    
  end
  
  def update
    @vote = Vote.where(article_id: params[:article_id], user_id: current_user.id).first
    @vote.update_column(:value, params[:value])
    @count = Vote.where(article_id: params[:article_id]).sum(:value)
    render json: {id: params[:article_id].to_i, vote: @count}
  end
  
  private
  def vote_params
    params.permit(:article_id, :value)
  end
end
