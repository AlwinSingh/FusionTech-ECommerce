package myservices;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.Response;

import org.json.JSONObject;

@Path("/currencyconverter")
public class CurrencyConverter {

	@Path("changeusercurrency")
	@GET
	@Produces("application/json")
	public Response changeUserCurrency(@QueryParam("convertTo") String convertTo) {

		// String str =
		// "{\"sgd\":\"12445.666\",\"rate\":\"1.37\",\"usd\":\"9060.32\",\"currency\":\"USD\"}";
		// obj.put("sgd", String.valueOf(sgd));
		// obj.put("usd", String.valueOf(Math.round(usd * 100.0) / 100.0));
		// obj.put("rate", String.valueOf(Math.round(currencyRate * 100.0) / 100.0));
		// obj.put("currency", "USD");
		// result = "{\"sgd\":\""+ String.valueOf(sgd)
		// +"\",\"rate\":\""+currencyRate+"\",\"usd\":\""+String.valueOf(Math.round(usd
		// * 100.0) / 100.0)+"\",\"currency\":\"USD\"}";
		// JSONObject obj = new JSONObject();

		String result = "";

		try {
			//double currencyRate = 1 / 0.72799;
			// double usd = sgd / currencyRate;

			if ((convertTo.toLowerCase()).contentEquals("usd")) {
				result = "{\"userCurrency\":\"USD\",\"currencyRate\":\"0.72799\",\"currencySymbol\":\"US$\"}";
			} else if ((convertTo.toLowerCase()).contentEquals("sgd")) {
				result = "{\"userCurrency\":\"SGD\",\"currencyRate\":\"1\",\"currencySymbol\":\"S$\"}";
			} else if ((convertTo.toLowerCase()).contentEquals("myr")) {
				result = "{\"userCurrency\":\"MYR\",\"currencyRate\":\"3.06\",\"currencySymbol\":\"RM\"}";
			}

		} catch (Exception e) {
			result = "{\"error\":\"Invalid conversion\"}";
		}

		// System.out.println(result);
		return Response.status(200).entity(result).build();
	}
}
