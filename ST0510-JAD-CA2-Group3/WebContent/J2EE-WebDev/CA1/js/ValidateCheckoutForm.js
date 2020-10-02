$("#same-address").click(function() {
	var checkStatus = $("#same-address").is(':checked');
	//console.log(checkStatus);
	
	if (checkStatus) {
		$("#shippingFormDetails").hide(500);
	} else {
		$("#shippingFormDetails").show(500);
	}
});

$("#contactless-delivery").click(function() {
	var checkStatus = $("#contactless-delivery").is(':checked');
	//console.log(checkStatus);
	
	if (checkStatus) {
		$("#contactless-delivery").attr('data-custom-value', 'Y');
		$("#contactless-delivery").val('Y');
	} else {
		$("#contactless-delivery").attr('data-custom-value', 'N');
		$("#contactless-delivery").val("N");
	}
});

function encryptPaymentCardNum() {
	var settings = {
			"async": true,
			"crossDomain": true,
			"url": "https://aria2-flbw-encryption-v1.p.rapidapi.com/",
			"method": "POST",
			"headers": {
				"x-rapidapi-host": "aria2-flbw-encryption-v1.p.rapidapi.com",
				"x-rapidapi-key": "d611edf274mshb77e73f2108e026p10744cjsnfb3efa560f2b",
				"content-type": "application/x-www-form-urlencoded"
			},
			"data": {
				"method": "1",
				"choice": "decipher",
				"passw": "mystrongpassword",
				"text": ($("#cc-number").val()).toString()
			}
		}

		$.ajax(settings).done(function (data) {
			console.log(data);
			$("#getPaymentCardEncrypted").val(data);
		})
};

function getPayment() {
	var paymentValue = $(".paymentValueWithGst").val();
	$("#getPaymentValue").val(paymentValue);
}

function verifyFormDetails(event) {
	var sameAddress = $("#same-address").is(':checked');
	var ignoreBillingDetails = true;
	
	if (sameAddress) {
		ignoreBillingDetails = true;
	} else {
		ignoreBillingDetails = false;
	}
	
	var deliveryType = $("#contactless-delivery").attr('data-custom-value');
	
	var shippingFirstName = $("#shippingFirstName").val();
	var shippingLastName = $("#shippingLastName").val();
	var shippingAddress = $("#shippingAddress").val();
	var shippingAddress2 = $("#shippingAddress2").val();
	var shippingCountry = $("#countryId").val();
	var shippingState = $("#stateId").val();
	var shippingCity = $("#cityId").val();
	var shippingPostalCode = $("#shippingPostalCode").val();
	
	if (shippingFirstName.length < 1 || shippingFirstName == "" || !shippingFirstName.match(/^[A-Za-z]+$/)) {
		$("#shippingFirstNameLabel").addClass('text-danger');
		$("#shippingFirstNameLabel").text('First name (Invalid)');
		event.preventDefault();
	} else {
		$("#shippingFirstNameLabel").removeClass('text-danger');
		$("#shippingFirstNameLabel").text('First name');
	}
	
	if (shippingLastName.length < 1 || shippingLastName == "") {
		$("#shippingLastNameLabel").addClass('text-danger');
		$("#shippingLastNameLabel").text('Last name (Invalid)');
		event.preventDefault();
	} else {
		$("#shippingLastNameLabel").removeClass('text-danger');
		$("#shippingLastNameLabel").text('Last name');
	}
	
	if (shippingAddress.length < 1 || shippingAddress == "") {
		$("#shippingAddressLabel").addClass('text-danger');
		$("#shippingAddressLabel").text('Address (Invalid)');
		event.preventDefault();
	} else {
		$("#shippingAddressLabel").removeClass('text-danger');
		$("#shippingAddressLabel").text('Address');
	}
	
	/*if (shippingCountry.length < 1 || shippingCountry == "" || !shippingCountry.match(/^[A-Za-z]+$/)) {
		$("#shippingCountryLabel").addClass('text-danger');
		$("#shippingCountryLabel").text('Country (Invalid)');
		event.preventDefault();
	} else {
		$("#shippingCountryLabel").removeClass('text-danger');
		$("#shippingCountryLabel").text('Country');
	}
	
	if (shippingState.length < 1 || shippingState == "" || shippingState == "Not Specified") {
		$("#shippingStateLabel").addClass('text-danger');
		$("#shippingStateLabel").text('State (Invalid)');
		event.preventDefault();
	} else {
		$("#shippingStateLabel").removeClass('text-danger');
		$("#shippingStateLabel").text('State');
	}
	
	if (shippingCity.length < 1 || shippingCity == "" || shippingCity == "Not Specified") {
		$("#shippingCityLabel").addClass('text-danger');
		$("#shippingCityLabel").text('City (Invalid)');
		event.preventDefault();
	} else {
		$("#shippingCityLabel").removeClass('text-danger');
		$("#shippingCityLabel").text('City');
	}*/
	
	if (shippingPostalCode.length < 1 || shippingPostalCode == "") {
		$("#shippingPostalCodeLabel").addClass('text-danger');
		$("#shippingPostalCodeLabel").text('Zip (Invalid)');
	} else {
		$("#shippingPostalCodeLabel").removeClass('text-danger');
		$("#shippingPostalCodeLabel").text('Zip');
	}

	if (ignoreBillingDetails) {
	console.log("Skipping verification...shipping = billing");
	} else {
		var billingFirstName = $("#billingFirstName").val();
		var billingLastName = $("#billingLastName").val();
		var billingAddress = $("#billingAddress").val();
		var billingAddress2 = $("#billingAddress2").val();
		var billingCountry = $("#billingCountry").val();
		var billingState = $("#billingState").val();
		var billingPostalCode = $("#billingPostalCode").val();
		
		if (billingFirstName.length < 1 || billingFirstName == "" || !billingFirstName.match(/^[A-Za-z]+$/)) {
			$("#billingFirstNameLabel").addClass('text-danger');
			$("#billingFirstNameLabel").text('First name (Invalid)');
			event.preventDefault();
		} else {
			$("#billingFirstNameLabel").removeClass('text-danger');
			$("#billingFirstNameLabel").text('First name');
		}
		
		if (billingLastName.length < 1 || billingLastName == "") {
			$("#billingLastNameLabel").addClass('text-danger');
			$("#billingLastNameLabel").text('Last name (Invalid)');
			event.preventDefault();
		} else {
			$("#billingLastNameLabel").removeClass('text-danger');
			$("#billingLastNameLabel").text('Last name');
		}
		
		if (billingAddress.length < 1 || billingAddress == "") {
			$("#billingAddressLabel").addClass('text-danger');
			$("#billingAddressLabel").text('Address (Invalid)');
			event.preventDefault();
		} else {
			$("#billingAddressLabel").removeClass('text-danger');
			$("#billingAddressLabel").text('Address');
		}
		
		if (billingCountry.length < 1 || billingCountry == "" || !billingCountry.match(/^[A-Za-z]+$/)) {
			$("#billingCountryLabel").addClass('text-danger');
			$("#billingCountryLabel").text('Country (Invalid)');
			event.preventDefault();
		} else {
			$("#billingCountryLabel").removeClass('text-danger');
			$("#billingCountryLabel").text('Country');
		}
		
		if (billingState.length < 1 || billingState == "" || billingState == "Not Specified" || !billingState.match(/^[A-Za-z]+$/)) {
			$("#billingStateLabel").addClass('text-danger');
			$("#billingStateLabel").text('State (Invalid)');
			event.preventDefault();
		} else {
			$("#billingStateLabel").removeClass('text-danger');
			$("#billingStateLabel").text('State');
		}
		
		if (billingPostalCode.length < 1 || billingPostalCode == "") {
			$("#billingPostalCodeLabel").addClass('text-danger');
			$("#billingPostalCodeLabel").text('Zip (Invalid)');
		} else {
			$("#billingPostalCodeLabel").removeClass('text-danger');
			$("#billingPostalCodeLabel").text('Zip');
		}
	}
	
	var paymentInputError = false;
	var ccHolderName = $("#cc-name").val();
	var ccNumber = $("#cc-number").val();
	var ccExpYear = $("#cc-exp-year").val();
	var ccExpMonth = $("#cc-exp-month").val();;
	var ccExpCVV = $("#cc-cvv").val();
	
	
	if (ccHolderName.length < 2 || ccHolderName == "") {
		$("#cc-nameLabel").addClass('text-danger');
		$("#cc-nameLabel").text('Name on card');
		paymentInputError = true;
		event.preventDefault();
	} else {
		$("#cc-nameLabel").removeClass('text-danger');
		$("#cc-nameLabel").text('Name on card');
		paymentInputError = false;
	}
	
	if (ccNumber.length < 13 || ccNumber.length > 19 || ccNumber == "" || ccNumber.match(/^[A-Za-z]+$/)) {
		$("#cc-numberLabel").addClass('text-danger');
		$("#cc-numberLabel").text('Credit card number');
		paymentInputError = true;
		event.preventDefault();
	} else {
		$("#cc-numberLabel").removeClass('text-danger');
		$("#cc-numberLabel").text('Credit card number');
		paymentInputError = false;
	}
	
	if (ccExpYear < 2020 || ccExpYear == "" || ccExpYear.match(/^[A-Za-z]+$/)) {
		$("#cc-expYearLabel").addClass('text-danger');
		$("#cc-expYearLabel").text('Expiration Year');
		paymentInputError = true;
		event.preventDefault();
	} else {
		$("#cc-expYearLabel").removeClass('text-danger');
		$("#cc-expYearLabel").text('Expiration Year');
		paymentInputError = false;
	}

	if (ccExpMonth == "") {
		$("#cc-expMonthLabel").addClass('text-danger');
		$("#cc-expMonthLabel").text('Expiration Month');
		paymentInputError = true;
		event.preventDefault();
	} else {
		$("#cc-expMonthLabel").removeClass('text-danger');
		$("#cc-expMonthLabel").text('Expiration Month');
		paymentInputError = false;
	}
	
	if (ccExpCVV.length < 3 || ccExpCVV.length > 4 || ccExpCVV == "" || ccExpCVV.match(/^[A-Za-z]+$/)) {
		$("#cc-cvvLabel").addClass('text-danger');
		$("#cc-cvvLabel").text('CVV');
		paymentInputError = true;
		event.preventDefault();
	} else {
		$("#cc-cvvLabel").removeClass('text-danger');
		$("#cc-cvvLabel").text('CVV');
		paymentInputError = false;
	}
	
	if (paymentInputError) {
		$("#paymentButton").addClass('text-danger');
	} else {
		$("#paymentButton").removeClass('text-danger');
	}
	
	getPayment();
	//encryptPaymentCardNum();
}