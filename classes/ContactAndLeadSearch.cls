public class ContactAndLeadSearch{
    public static List<List< SObject>> searchContactsAndLeads(String searchKey){
        return [FIND :searchKey IN ALL FIELDS RETURNING Contact(FirstName, LastName),Lead(FirstName, LastName)];
    }
}