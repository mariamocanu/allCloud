@isTest 
public class BatchAllAcountsUpdateTest{
    
    @testSetup static void setup() {
        List<Account> lstAccount= new List<Account>();
            for(Integer i=0;i<5;i++){
                Account acc = new Account();
                acc.Name ='Name'+i;
                acc.BillingCity = 'London';
                lstAccount.add(acc);
            }
            insert lstAccount;
    }
        
    @isTest
    public static void testAccountCurrentWeatherIsPopulated() {
        List<Account> insertedAccounts = [SELECT Id, Name, BillingCity, BillingState, BillingCountry, AccountCurrentWeather__c FROM Account];
        
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        BatchAllAccountsUpdate baau = new BatchAllAccountsUpdate();
        baau.execute(null, insertedAccounts);	
        Test.stopTest();
        
        System.assertEquals(5, insertedAccounts.size(),'5 accounts have been inserted.');
        
        for(Account acc:insertedAccounts){
            System.assertEquals(false, String.isEmpty(acc.AccountCurrentWeather__c));
        }
        
    }
}