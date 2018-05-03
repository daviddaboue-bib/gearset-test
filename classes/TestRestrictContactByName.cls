@isTest
public class TestRestrictContactByName {
	@isTest static void TestCreateContactWithInvalidName() {
        // Test data setup
        // Create an account with an opportunity, and then try to delete it
        Account acct = new Account(Name='Test Account');
        insert acct;
        Contact ct = new Contact(AccountID = acct.Id, FirstName = 'First', LastName='INVALIDNAME');
        
        
        // Perform test
        Test.startTest();
        Database.SaveResult result = Database.insert(ct, false);
        Test.stopTest();

        // Verify 
        // In this case the deletion should have been stopped by the trigger,
        // so verify that we got back an error.
        System.assert(!result.isSuccess());
        System.assert(result.getErrors().size() > 0);
        System.assertEquals('The Last Name "'+ct.LastName+'" is not allowed for DML',
                             result.getErrors()[0].getMessage());
    }
}