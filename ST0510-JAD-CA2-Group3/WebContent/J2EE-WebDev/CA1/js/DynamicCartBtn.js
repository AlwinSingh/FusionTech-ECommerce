		     $(document).ready(function() {
		    	 //Retrieves element value
		    	 var pdtQty = $("#getProductQty").attr('value');
		    	 if (pdtQty < 1) {
		    		//If product quantity is less than 1, alters the button to be 'No Stock'
		    		$("#cartBtn").prop("disabled",true);
	    			$("#cartBtn").html('<button id="cartBtn" class="btn btn-danger btn-md my-0 mx-5 p waves-effect waves-light" type="submit" disabled>Out of stock</button>');
		    		//Prevents reloading
	    			return;
		    	 }
		    	 
		    		/*var userStatusValue = $("#userStatusValue").attr('value');
		    		if (userStatusValue.toLowerCase() == "guest") {
		    			//If a user is a guest, disable add to cart button
		    			$(this).prop("disabled",true);
		    			$("#cartBtn").addClass("disabled");
		    			$("#cartBtn").html('<button id="cartBtn" class="btn btn-primary btn-md my-0 mx-5 p waves-effect waves-light" type="submit" disabled>Add to cart</button>');
		    		} else {
		    			$(this).prop("disabled",false);
		    			$("#cartBtn").removeClass("disabled");
		    			$("#cartBtn").html('<button id="cartBtn" class="btn btn-primary btn-md my-0 mx-5 p waves-effect waves-light" type="submit">Add to cart</button>');

		    		}*/
		     });