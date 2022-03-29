public class WeatherByLocationController {
	@AuraEnabled(cacheable=true)
    public static String getWeather(Id accId){
        Account currentAccount = [SELECT Id, Name, BillingStreet, BillingCity, BillingState, BillingCountry FROM Account where Id = :accId LIMIT 1];
        WeatherResponse weatherResponse = weatherProxy.getWeatherResponse(currentAccount);
        /*String responseText = weatherProxy.getLatLongByData(currentAccount);
        List<CoordinatesResponse> coordinatesObj = (List<CoordinatesResponse>) JSON.deserialize(responseText, List<CoordinatesResponse>.class);
        Decimal lat = coordinatesObj[0].lat;
        Decimal lon = coordinatesObj[0].lon;
        String weatherResponseText = weatherProxy.getWeatherByCoordinates(lat,lon);
        WeatherResponse weatherResponse = (WeatherResponse) JSON.deserialize(weatherResponseText, WeatherResponse.class);
        weatherResponse.address = currentAccount.BillingCity;
		*/
        return JSON.serialize(weatherResponse);
    } 
}