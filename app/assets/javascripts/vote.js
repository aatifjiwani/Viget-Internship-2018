
var $articles = $(".article-up")
if ($articles.length) {
    $articles = $articles.add($(".article-down"));
    $articles.bind('ajax:success', function(evt, data, status, xhr) {
        changeVoteCount(evt, data, status, xhr, "Article");
    });
}

var $comments = $(".comment-up");
if ($comments.length) {
    $comments = $comments.add($(".comment-down"));
    $comments.bind('ajax:success', function(evt, data, status, xhr) {
        changeVoteCount(evt, data, status, xhr, "Comment");
    });
}


function changeVoteCount(evt, data, status, xhr, voteable_type) {
    response = evt['detail'][0];
    //Heroku does not have ES6 transpiling
    elements = document.getElementsByClassName("vote-" + voteable_type + "-count-" + response['id']);
    elButtonUps = document.getElementsByClassName("vote-" + voteable_type + "-button-up-" + response['id']);
    elButtonDowns = document.getElementsByClassName("vote-" + voteable_type + "-button-down-" + response['id']);

    for (i = 0; i < elements.length; i++) {
        if (response['path_up'] && response['path_down']) {
            elButtonUps[i].setAttribute('href', response['path_up']);
            elButtonUps[i].setAttribute('data-method', 'put');
            
            elButtonDowns[i].setAttribute('href', response['path_down']);
            elButtonDowns[i].setAttribute('data-method', 'put');
        }
        elements[i].innerHTML = response['vote'];
    }
}

