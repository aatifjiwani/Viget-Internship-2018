class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params.merge(user: current_user))

    if @comment.save
      flash[:notice] = "Comment saved."
      redirect_to article_path(@comment.parent_article)
    else
      flash[:alert] = "Unable to save comment. Please try again."
      #If there is a better way to write this logic, please tell me. 
      #Apparently, inline if-else doesn't syntactically work

      redirect_to article_path(params[:parent_article])
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :commentable_type, :commentable_id, :parent_article)
  end
end
