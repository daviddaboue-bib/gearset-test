@isTest
public class AddPrimaryContactTest {
	@testSetup
	static void setup()
    {
        List<Account> accounts2insert = new List<Account>();
        for(Integer x=0; x<50; x++)
        {
			accounts2insert.add(new Account(
            	Name = 'NY Account '+x,
                BillingState =  'NY'
            ));
        }
        
        for(Integer x=0; x<50; x++)
        {
			accounts2insert.add(new Account(
            	Name = 'CA Account '+x,
                BillingState = 'CA'
            ));
        }
        
        insert accounts2insert;
    }
    
    @isTest(seeAllData  = false)
    static void testQueueable() 
    {
        AddPrimaryContact job = new AddPrimaryContact(new Contact(LastName = 'Primary Contact'),'CA');
		Test.startTest();
        	System.enqueueJob(job);
        Test.stopTest();
        System.debug('Total Contacts'+[SELECT count() FROM Contact ]);
        System.assertEquals(50, [SELECT count() FROM Contact WHERE Account.BillingState = 'CA']);
    }
    
}