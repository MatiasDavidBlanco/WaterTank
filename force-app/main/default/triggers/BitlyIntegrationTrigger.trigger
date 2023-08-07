trigger BitlyIntegrationTrigger on Tipo_de_Tanque__c (after insert) {
	 // Lista para almacenar los IDs de los registros de tanque que se han creado
    List<Id> tipoTanqueIds = new List<Id>();

    // Recorrer los registros de tanque recién creados y obtener sus IDs
    for (Tipo_de_Tanque__c tanque : Trigger.new) {
        tipoTanqueIds.add(tanque.Id);
    }

    // Llamar al método obtenerEnlaceCorto de la clase BitlyIntegration para cada registro de tanque
  
    BitlyIntegration.obtenerEnlaceCorto(tipoTanqueIds);
    
}