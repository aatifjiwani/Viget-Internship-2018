class CommentsController < ApplicationController
  before_action :get_parent

  def create
    @comment = @parent.comments.new(comment_params.merge(user: current_user))
    
    if @comment.save
      flash[:notice] = "Comment saved."
      redirect_to article_path(@comment.parent_post)
    else
      flash[:alert] = "Unable to save comment. Please try again."
      #If there is a better way to write this logic, please tell me. 
      #Apparently, inline if-else doesn't syntactically work
      if @parent.is_a?(Article)
        redirect_to article_path(@parent)
      else
        redirect_to article_path(@parent.parent_post)
      end
    end
  end

  private
  def get_parent
    @parent = Article.find(params[:article_id]) if params[:article_id]
    @parent = Comment.find(params[:comment_id]) if params[:comment_id]

    redirect_to articles_path unless defined?(@parent)
  end

  def comment_params
    params.require(:comment).permit( :body)
  end
end
