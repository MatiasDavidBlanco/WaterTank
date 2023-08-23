trigger BitlyIntegrationTrigger on Tipo_de_Tanque__c (before insert, after insert, before update, after update) {
    if (Trigger.isInsert && Trigger.isAfter) {
        BitlyIntegration.generateBitly(Trigger.new);
    }
    
    if (Trigger.isUpdate && Trigger.isAfter) {
        BitlyIntegration.generateBitly(Trigger.new);
    }
}
