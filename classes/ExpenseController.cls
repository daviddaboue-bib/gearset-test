public class ExpenseController 
{
	@AuraEnabled
	public static List<Expense__c> getExpenses()
	{
		return [
			SELECT Id,Name,
				dabs__Amount__c,
				dabs__Approved__c,
				dabs__Client__c,
				dabs__Date__c,
				dabs__Reimbursed__c
			FROM dabs__Expense__c
			ORDER BY CreatedDate DESC
		];
	}

	@AuraEnabled
	public static Expense__c saveExpense(Expense__c expense)
	{
		upsert expense;
		return expense;
	}
}