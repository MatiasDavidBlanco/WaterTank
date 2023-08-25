// Trigger que maneja la integración con Bitly para el objeto personalizado Tipo_de_Tanque__c
trigger BitlyIntegrationTrigger on Tipo_de_Tanque__c (before insert, after insert, before update, after update) {
    
    // Se verifica si el contexto actual no es un contexto de Batch ni un contexto futuro
    if (System.IsBatch() == false && System.isFuture() == false) { 

        // Se ejecuta cuando hay una inserción y después de la inserción
        if (Trigger.isInsert && Trigger.isAfter) {
            BitlyIntegration.generateBitly(Trigger.new);
        }
        
        // Se ejecuta cuando hay una actualización y después de la actualización
        if (Trigger.isUpdate && Trigger.isAfter) {
            BitlyIntegration.generateBitly(Trigger.new);
        }
    }
}