public with sharing class GetRecordDataController {
 @AuraEnabled(cacheable=true)
  public static List<Account> getAccounts() {
    return [SELECT Id, Name, ShippingAddress, BillingAddress FROM Account];
  }
}