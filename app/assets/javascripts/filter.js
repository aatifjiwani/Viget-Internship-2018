$('#article_select').on('change', function(){
  $("#article_filter").submit();
  /*$.ajax({ type: "GET",
     url: "/articles",
     data: { article_options: $('option:selected', this).val() }
  }).done(function(data) {
    //console.log(response);
    response = data['list'];
    console.log(response);
    //$("#article-list").html("<%= escape_javascript(render partial: 'articles/list'), locals: {articles: [" + response + "] }) %>");
    $("#article-list").html("<%= escape_javascript(render partial: 'articles/list'), locals: {articles: [] }) %>");
    //$("article-list").html("2");
  });*/
});