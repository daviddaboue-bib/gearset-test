trigger opportunityTrigger on Opportunity (after update) {
    set<Id> oppId = new set<Id>();
    list<Asset> assetsToInsert = new list<Asset>();
        
    map<Id,Opportunity> mapOpp = new map<Id,Opportunity>();
    
    for(Opportunity o: Trigger.new){
        if(o.StageName == 'Closed Won'){
            oppId.add(o.Id);
        }
    }
    
    
    
    list<Opportunity> lstOpp = [Select o.Id, (Select OpportunityId, PricebookEntry.Product2Id, PricebookEntry.Product2.Name From OpportunityLineItems) From Opportunity o Where o.Id IN : oppId];
    
    
    if(lstOpp.size() > 0){
        // OppLineItems
        for(Opportunity o: lstOpp ){
            mapOpp.put(o.Id, o);
        }
    }

    //-- Creation de l'Asset
    
    for(Opportunity o: Trigger.new){
        if(mapOpp.size() > 0 && mapOpp.get(o.Id) != null){
            Opportunity my_opp = mapOpp.get(o.Id);
            list<OpportunityLineItem> lstLineItems = my_opp.OpportunityLineItems;
            
            
            if(lstLineItems.size() > 0){
                for(OpportunityLineItem line : lstLineItems){
                    Asset my_asset = new Asset(); 
                    my_asset.Product2Id = line.PricebookEntry.Product2Id;
                    my_asset.Name = line.PricebookEntry.Product2.Name; 
                    my_asset.AccountId = o.AccountId;
                    
                    my_asset.Opportunity__c = o.Id;
                    assetsToInsert.add(my_asset);
                }
            } 
        }
    }
    
    if(!assetsToInsert.isEmpty()){
        insert assetsToInsert;
    }
}