public class AddPrimaryContact implements Queueable
{
    public String state;
    public Contact ct;
    public AddPrimaryContact(Contact ct, String state)
    {
        this.ct = ct;
        this.state = state;
    }
    
	public void execute(QueueableContext context)
    {
        List<Contact> contacts2insert = new List<Contact>();
        for(Account acc : [SELECT Id FROM Account WHERE BillingState = :state LIMIT 200])
        {
            Contact c = ct.clone();
            	c.AccountId = acc.Id;
         	contacts2insert.add(c);   
        }
        System.debug('contacts2insert::'+contacts2insert.size());
        insert contacts2insert; 
    }
}