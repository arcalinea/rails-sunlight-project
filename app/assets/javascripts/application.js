// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .

$(document).ready(function() {
  $('#search #new_search').submit(function(e){
  	e.preventDefault();
  	var results = $(this).serializeArray()
  	var url = $(this).attr("action");
  	var method = $(this).attr("method");
  	
  	console.log(results)
  	console.log(url)
  	console.log(method)

  	$.ajax({
  		url: url,
  		method: method,
  		data: results
  	})
  	.done(function(response){
  		console.log("Response: " + response);
  		$(response).appendTo('#search-results');
  	})
    // $('#search #new_search').reset();
  });

});

