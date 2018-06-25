
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
    element = $("#vote-" + voteable_type + "-count-" + response['id']);
    if (response['path_up'] && response['path_down']) {
        $('#vote-' + voteable_type + '-button-up-' + response['id']).attr({
            'href': response['path_up'],
            'data-method': 'put'
        });

        $('#vote-' + voteable_type + '-button-down-' + response['id']).attr({
            'href': response['path_down'],
            'data-method': 'put'
        });
    }
    element.html(response['vote']);
}

