module ApplicationHelper
  def up_vote_links(voteable_type, voteable_id, method)
    link_to("", votes_path(voteable_id: voteable_id, voteable_type: voteable_type, value: 1), method: method, remote: true, id: "vote-#{voteable_type}-button-up-#{voteable_id}", class: "#{voteable_type.downcase}-vote-top")
  end

  def down_vote_links(voteable_type, voteable_id, method)
    link_to("", votes_path(voteable_id: voteable_id, voteable_type: voteable_type, value: -1), method: method, remote: true, id: "vote-#{voteable_type}-button-down-#{voteable_id}", class: "#{voteable_type.downcase}-vote-bottom")
  end
end