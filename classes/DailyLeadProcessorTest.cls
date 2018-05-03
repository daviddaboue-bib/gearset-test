@isTest
public class DailyLeadProcessorTest 
{
	@testSetup
	static void setup()
    {
        List<Lead> leads2insert = new List<Lead>();
        for(Integer x=0; x<200; x++)
        {
			leads2insert.add(new Lead(
            	LastName = 'Lead '+x,
                Company = 'Company '+x
            ));
        }
        
        insert leads2insert;
    }
    
    @isTest(seeAllData  = false)
    static void testSchedulable() 
    {
        Test.startTest();
        	String jobId = System.schedule('ScheduledApexTest', '0 0 0 15 3 ? 2022', new DailyLeadProcessor());
        Test.stopTest();
        
        System.assertEquals(200, [SELECT count() FROM Lead WHERE LeadSource = 'Dreamforce']);
    }
}