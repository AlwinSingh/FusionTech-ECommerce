var cartStatus = $("#cartItems").val();

console.log(cartStatus);

if (parseInt(cartStatus) == 0) {
	$(".cartContainer").hide().load('../HTML/emptyCart.html').fadeIn('3000');
}

$(".infoAnchor").hover(function() {
	event.preventDefault();
	$('.infoAnchor').popover();
});