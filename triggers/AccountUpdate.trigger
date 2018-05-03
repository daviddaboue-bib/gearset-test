trigger AccountUpdate on Account (before update) {
System.debug('STARTED AccountUpdate');
    for (Integer x=0; x<Trigger.new.size(); x++) {
        Account newAcc = Trigger.new[x];    
        system.debug('Email:: '+newAcc.LastModifiedBy.Email);
    }
 System.debug('ENDED AccountUpdate');   
}