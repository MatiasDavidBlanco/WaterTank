trigger BitlyIntegrationTrigger on Tipo_de_Tanque__c (before insert, after insert, before update, after update) {
    if(System.IsBatch() == false && System.isFuture() == false){ 

        if (Trigger.isInsert && Trigger.isAfter) {
            BitlyIntegration.generateBitly(Trigger.new);
        }
        
        if (Trigger.isUpdate && Trigger.isAfter) {
            BitlyIntegration.generateBitly(Trigger.new);
        }
    }
}
