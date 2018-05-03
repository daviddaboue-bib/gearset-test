public class ContactSearch {
    public static List<Contact> searchForContacts(String lastName, String postalCode)
    {
        List<Contact> ret = new List<Contact>(); 
        if(!String.isBlank(lastName) && !String.isBlank(postalCode)){
            ret = [SELECT Id, Name FROM Contact WHERE LastName = :lastName AND MailingPostalCode = : postalCode];
        }
        
        return ret;
    }
}