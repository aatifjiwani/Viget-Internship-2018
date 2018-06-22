function changeVoteCount(evt, data, status, xhr, voteable_type) {
    response = evt['detail'][0];
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