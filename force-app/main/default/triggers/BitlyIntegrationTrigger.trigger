trigger BitlyIntegrationTrigger on Tipo_de_Tanque__c (before insert, after insert, before update, after update) {

    if (Trigger.isAfter) {
        if (Trigger.isInsert) {
            BitlyIntegration.generateBitly(Trigger.new);
        }
        if (Trigger.isUpdate) {
            BitlyIntegration.generateBitly(Trigger.new);
        }
    }
}

