module VotesHelper
  def voteable_has_user_vote?(voteable)
    voteable.votes.where(user: current_user).any?
  end

  def total_votes(voteable)
    voteable.votes.sum(:value)
  end
end