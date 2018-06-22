function changeVoteCount(evt, data, status, xhr) {
    response = evt['detail'][0];
    element = $("#vote-count-" + response['id']);
    if (response['path_up'] && response['path_down']) {
        $('#vote-button-up-' + response['id']).attr({
            'href': response['path_up'],
            'data-method': 'put'
        });

        $('#vote-button-down-' + response['id']).attr({
            'href': response['path_down'],
            'data-method': 'put'
        });
    }
    element.html(response['vote']);
}