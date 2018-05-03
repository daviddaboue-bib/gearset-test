public class StringArrayTest 
{
    public static List<String> generateStringArray(Integer nb)
    {
        List<String> ret = new List<String>(); 
        if(nb > 0)
        {
            for(Integer i=0; i<nb; i++){
                ret.add('Test '+i);
            }
        }
        return ret;
    }
}