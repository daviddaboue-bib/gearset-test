@isTest
private class TestVerifyDate{
    @isTest static void testCheckDates(){
        Date dt = Date.today();
        
        Date dt1 = VerifyDate.CheckDates(dt, dt.addDays(20));
        Date dt2 = VerifyDate.CheckDates(dt, dt.addDays(32));
        
        System.assertEquals(dt1,dt.addDays(20));
    }
}