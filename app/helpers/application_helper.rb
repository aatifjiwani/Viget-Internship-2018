module ApplicationHelper
  def up_vote_links(article_id, method)
    link_to("", votes_path(article_id: article_id, value: 1), method: method, remote: true, id: "vote-button-up-#{article_id}", class: "article-vote-top")
  end

  def down_vote_links(article_id, method)
    link_to("", votes_path(article_id: article_id, value: -1), method: method, remote: true, id: "vote-button-down-#{article_id}", class: "article-vote-bottom")
  end
end