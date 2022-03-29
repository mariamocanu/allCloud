public class WeatherProxy {
	
    public static String getLatLongByData(Account currentAccount){
        HttpRequest req = new HttpRequest();
        HTTPResponse res = new HTTPResponse();
        try{
            string apiKey = getAPIkey();
            string endpoint = getLatLongEndpoint(apiKey, currentAccount.BillingCity, currentAccount.BillingState, currentAccount.BillingCountry);
            req.setEndpoint(endpoint);
            req.setMethod('GET');
            
            Http http = new Http();
            req.setTimeout(20000);
            res = http.send(req);
            
        }catch(Exception e){
            System.debug('=====>>> exception: '+e);
        }
        return res.getBody();  
    }
    
    public static String getWeatherByCoordinates(Decimal lat, Decimal lon){
        HttpRequest req = new HttpRequest();
        HTTPResponse res = new HTTPResponse();
        try{
            string apiKey = getAPIkey();
            string endpoint = getWeatherEndpoint(apiKey, lat, lon);
            req.setEndpoint(endpoint);
            req.setMethod('GET');
            
            Http http = new Http();
            req.setTimeout(20000);
            res = http.send(req);
            
        }catch(Exception e){
            System.debug('=====>>> exception: '+e);
        }
        return res.getBody();  
    }
        
    private static String getAPIkey(){
        APIKeys__c objAPIKeys = APIKeys__c.getInstance();
		return objAPIKeys.API_Key__c;
    }
    
    private static String getWeatherEndpoint(String apiKey, Decimal latitude, Decimal longitude){
        return 'https://api.openweathermap.org/data/2.5/onecall?lat='+ latitude + '&lon=' + longitude + '&appid=' + apiKey;
    }
    
    private static String getLatLongEndpoint(String apiKey, string cityName, string state, string country){
        return 'https://api.openweathermap.org/geo/1.0/direct?q=' + cityName + ',' + state + ',' + country +  '&limit=1&appid=' + apiKey;
    }
    
    public static WeatherResponse getWeatherResponse(Account acc){
        String responseText = weatherProxy.getLatLongByData(acc);
        List<CoordinatesResponse> coordinatesObj = (List<CoordinatesResponse>) JSON.deserialize(responseText, List<CoordinatesResponse>.class);
        if(coordinatesObj.size() == 0 || coordinatesObj.isEmpty()){
            return null;
        }
        Decimal lat = coordinatesObj[0].lat;
        Decimal lon = coordinatesObj[0].lon;
        String weatherResponseText = weatherProxy.getWeatherByCoordinates(lat,lon);
        WeatherResponse weatherResponse = (WeatherResponse) JSON.deserialize(weatherResponseText, WeatherResponse.class);
        weatherResponse.address = acc.BillingCity;

        return weatherResponse;
    }
}