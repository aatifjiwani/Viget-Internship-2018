module VotesHelper
  def voteable_has_user_vote?(voteable)
    voteable.votes.where(user: current_user).any?
  end

  def total_votes(voteable)
    voteable.votes.sum(:value)
  end

  def user_vote_articles(array_of_ids)
    array_of_ids.map! {|x| Article.find(x)}
  end

  def user_votes(user)
    user_vote_articles(Vote.user_articles_voted(user).pluck(:voteable_id))
  end
end