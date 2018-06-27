module ApplicationHelper
  def up_vote_links(voteable_type, voteable_id, method)
    link_to("", upvotes_path(voteable_id: voteable_id, voteable_type: voteable_type), method: method, remote: true, class: "vote-#{voteable_type}-button-up-#{voteable_id} #{voteable_type.downcase}-vote-top #{voteable_type.downcase}-up")
  end

  def down_vote_links(voteable_type, voteable_id, method)
    link_to("", downvotes_path(voteable_id: voteable_id, voteable_type: voteable_type), method: method, remote: true, class: "vote-#{voteable_type}-button-down-#{voteable_id} #{voteable_type.downcase}-vote-bottom #{voteable_type.downcase}-down")
  end
end