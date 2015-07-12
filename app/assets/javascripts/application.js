// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery-ui/effect-blind
//= require jquery_ujs
//= require turbolinks
//= require_tree .

$( document ).ready(function() {

	var set_stars = function(form_id, stars){
			for(i=1; i<=5; i++){    // turns stars on and off
 				if(i <= stars) {      // 1..5 stars add each 1
 					$('#' + form_id + '_' + i).addClass('on');	
 				} else {
 					$('#' + form_id + '_' + i).removeClass('on');	
 				}
 			}
	}
}

$function() {
 	$('.rating_star').click(function () {
 			var star = $(this);
 			var form_id = $(this).attr('product-form-id');
 			var stars = $(this).attr('product-stars');
 		

 			set_stars(form_id, stars);

 			$('#' + form_id + '_stars').val(stars);

 			$.ajax({
 				type: "post",															// takes ratings given
 				url: $( '#' + form_id).attr("action");    // uses the form
 				data: $( '#' + form_id).serialize()       // puts in db
 			});

 	});
});

$('star_rating_form').each(function() {
	var form_id = $(this).attr('id');
	var stars = $('#' + form_id + '_stars').val();
	set_stars(form_id, stars);


});










