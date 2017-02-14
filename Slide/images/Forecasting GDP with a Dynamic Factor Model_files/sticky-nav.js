// JavaScript Document
$(document).ready(function(){
	bannerheight = 0;
	//get banner height
	$(".sticky_header_container > .grid_192").each(function() { bannerheight += $(this).height(); });

	//Affix the banner	
	$(".sticky_header_container").affix({offset: $('.sticky_header_container .grid_192').position()})
	$(".sticky_header_container + .content_frame").css("margin-top", bannerheight+"px");

	$(".anchor").css("padding-top", (bannerheight+15)+"px").css("margin-top", ((bannerheight+15)*-1)+"px");

	// Check for IE8 to manually change the margin-top based on scroll instead of using CSS
	if (navigator.appVersion.indexOf("MSIE 8")>0 || navigator.appVersion.indexOf("MSIE 7")>0) { 
		$(window).on("scroll", function() {
			if ($(this).scrollTop() < 90) {
			$(".content_frame").css("margin-top", 0);
			} else {
			$(".content_frame").css("margin-top", 83);
			}
		});
	} 

	//Add spying
	$(".local_subnav ul").addClass("nav");
	$("body").scrollspy({ "offset": -90 }); //90 is the height of the area above the sticky navs
	
	//Add the top button
	$("<div class='go-top'></div>").click(function(event) {
		event.preventDefault();
		$('html, body').animate({scrollTop: 0}, 300);
	}).appendTo("body");

	$(window).on("scroll", function() {
		if ($(this).scrollTop() > 200) {
			$('.go-top').fadeIn(200);
		} else {
			$('.go-top').fadeOut(200);
		}
	});
	
	
});