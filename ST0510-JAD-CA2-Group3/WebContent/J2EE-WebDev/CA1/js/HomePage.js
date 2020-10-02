var i = 0;
var j = 0;
var proceedToSecondWord = false;
var txt = 'Established 2019';
var txt2 = 'Best E-Commerce';
var speed = 80;

function typeWriter() {
	if (i <= txt.length) {
		if (i === txt.length) {
			//Checks if the first word is cleared
			proceedToSecondWord = true;

			//If first word is done printing out, proceed to the second
			if (proceedToSecondWord) {
				$("#fusionTechWelcomeHeader").hide();
				$("#fusionTechWelcomeHeaderTwo").css('display', 'block');
				if (j < txt2.length) {
					//So long as j is less than the length of the text 'Best E-Commerce' it will alter the html element
					document.getElementById("fusionTechWelcomeHeaderTwo").textContent += txt2
							.charAt(j);
					//.charAt retrieves the specific index to insert the next character
					j++;
					//Set timeout will keep firing and its 'speed' or rather timing is adjustable via the variable declared as 'speed'
					setTimeout(typeWriter, speed);
				}
			}

		} else {
			//If first word is not done, print it out. Functionality is same as the above.
			document.getElementById("fusionTechWelcomeHeader").textContent += txt
					.charAt(i);
			i++;
			setTimeout(typeWriter, speed);
		}
	}
}

//Calls the function
typeWriter();







function GetURLParameter(sParam) {
	var sPageURL = window.location.search.substring(1);
	//As URL parameters are split via '&', it retrieves the parameter title (e.g. 'errCode')
	var sURLVariables = sPageURL.split('&');
	for (var i = 0; i < sURLVariables.length; i++) {
		var sParameterName = sURLVariables[i].split('=');
		if (sParameterName[0] == sParam) {
			return sParameterName[1];
		}
	}
}

//These variables retrieves the respective URL Parameters' value
var errCode = GetURLParameter('error');
var UpdateCustomer = GetURLParameter('UpdateCustomer');

//If the value matches either of the conditions below, it updates the text content of the html element
if (errCode) {
	if (errCode == 'unauthorised') {
		$(".unauthoriseAlert").text('Oops! You tried to access an unauthorised page!');
	} else if (errCode == 'notLoggedIn') {
		$(".unauthoriseAlert").text('Oops! You must be logged in to access that page!');
	}
	$(".unauthoriseAlert").css('display', 'block');
	$(".unauthoriseAlert").fadeIn();
} else {
	$(".unauthoriseAlert").css('display', 'none');
	
	if (UpdateCustomer == 'true') {
		$(".unauthoriseAlert").text('You updated your role! We thank you for your contribution!');
		$(".unauthoriseAlert").css('display', 'block');
		$(".unauthoriseAlert").fadeIn();
	} else {
		$(".unauthoriseAlert").css('display', 'none');
	}
	
}