public class AccountHandler {
    public static Account insertNewAccount(String name)
    {
        if(String.IsBlank(name)) return null;
        
        Account acc = new Account(Name = name);
        insert acc; 
        //Demo Hello World
                
        return acc;
    }
}