module VotesHelper
  def voteable_has_user_vote?(voteable)
    voteable.votes.where(user: current_user).any?
  end

  def total_votes(voteable)
    voteable.votes.sum(:value)
  end

  def user_vote_articles(arr)
    arr.map! {|x| Article.find(x)}
  end
  
  def user_votes(user)
    user_vote_articles(Vote.user_articles_voted(user))
  end
end