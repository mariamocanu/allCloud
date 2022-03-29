global class BatchAllAccountsUpdate implements Database.Batchable<sObject>, Database.AllowsCallouts{
     global Database.QueryLocator start(Database.BatchableContext BC){
        String query = 'SELECT Id, Name, BillingCity, BillingCountry, BillingState, AccountCurrentWeather__c FROM Account WHERE BillingCity<>null';
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext BC, List<Account> accounts){
        for(Account acc : accounts){
            WeatherResponse weatherResponse = WeatherProxy.getWeatherResponse(acc);
            if(weatherResponse == null){
                continue;
            }
            acc.AccountCurrentWeather__c = weatherResponse.current.weather[0].description;
        }
        update accounts;
    }
    
     global void finish(Database.BatchableContext BC) {}
}