public class RandomContactFactory {
	public static List<Contact> generateRandomContacts(Integer numContacts, String lastName){
        List<Contact> contacts = new List<Contact>();
        for(Integer x =0; x<numContacts; x++){
            contacts.add(new Contact(FirstName='Test '+x, LastName=lastName));
        }
        return contacts;
    }
}