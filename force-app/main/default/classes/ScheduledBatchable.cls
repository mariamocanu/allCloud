global class ScheduledBatchable implements Schedulable {
   global void execute(SchedulableContext sc) {
      BatchAllAccountsUpdate batch = new BatchAllAccountsUpdate(); 
      Database.executeBatch(batch);
   }
}