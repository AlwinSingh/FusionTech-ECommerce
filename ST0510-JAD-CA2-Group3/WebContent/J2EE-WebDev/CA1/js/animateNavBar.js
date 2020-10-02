$(function() {
	$(document).scroll(function() {
		//This gets the value, if you are at the top of the page, it is 0, hence this condition checks that
		if ($(window).scrollTop() === 0) {
			$(".fusionTechNavBar").css({
				"border" : "none"
			});
			return;
		} else {
			//If it is not at the top of the page, it alters the CSS and adds the animation via JQuery (.animate function)
			$(".fusionTechNavBar").css({
				"border-bottom-color" : "#5bc0de",
				"border-bottom-width" : "0px",
				"border-bottom-style" : "solid"
			}).animate({
				borderWidth : 2
			}, 350);
		}
	});
});