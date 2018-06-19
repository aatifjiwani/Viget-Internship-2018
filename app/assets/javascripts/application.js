// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require_tree .
//= require ckeditor/init

function createFormattingToolBar() {
    ClassicEditor.create( document.querySelector( '#article_body' ), {
      toolbar: [ 'heading', '|', 'bold', 'italic', 'bulletedList', 'numberedList', 'link', 'blockQuote' ]
    });
}

function createReplyToolBar() {
    ClassicEditor.create( document.querySelector( '#comment_body' ), {
      toolbar: [ 'heading', '|', 'bold', 'italic', 'bulletedList', 'numberedList', 'link', 'blockQuote' ], width: 400, height: 300
    });
}


function collapseReplyDiv(name) {
    var link = "link-" + name;
    document.getElementById(link).style["display"] = "none";
    
    var div = "form-" + name;
    document.getElementById(div).style["display"] = "block"; 
}

function revCollapseReplyDiv(name) {
    var link = "link-" + name;
    document.getElementById(link).style["display"] = "block";
    
    var div = "form-" + name;
    document.getElementById(div).style["display"] = "none"; 
}