@isTest
private class BitlyIntegrationTriggerTest {
	@isTest
    static void Insert_BitlyIntegrationTrigger(){
        //Preparación
        Tipo_de_Tanque__c tanque = new Tipo_de_Tanque__c();
        tanque.Name = 'Almacenamiento medido';
        tanque.Capacidad__c = 12345;
        tanque.URL_Corto__c = 'https://sforce.co/3E71RfR';
        
        //Ejecución
        Test.startTest();
        insert tanque;
        Test.stopTest();
        
        //Verificación
        Tipo_de_Tanque__c tanqueResponse = [SELECT Id, URL_Corto__c FROM Tipo_de_Tanque__c WHERE Id =:tanque.Id ];
        
        System.assertNotEquals(null, tanqueResponse.URL_Corto__c, 'La URL corta no debe ser nula');
        System.assertNotEquals('', tanqueResponse.URL_Corto__c, 'La URL corta no debe estar vacía');
    }
    @isTest
    static void Update_BitlyIntegrationTrigger(){
        //Preparación
        Tipo_de_Tanque__c tanque = new Tipo_de_Tanque__c();
        tanque.Name = 'Almacenamiento medido';
        tanque.Capacidad__c = 12345;
        tanque.URL_Corto__c = 'https://sforce.co/3E71RfR';
        insert tanque;
        tanque.Name = 'Almacenamiento desmedido' ;
        
        //Ejecución
        Test.startTest();
        update tanque;
        Test.stopTest();
        
        //Verificación
        Tipo_de_Tanque__c tanqueResponse = [SELECT Id, Name FROM Tipo_de_Tanque__c WHERE Id =:tanque.Id ];
        
        System.assertEquals('Almacenamiento desmedido', tanqueResponse.Name);
     
    }
}