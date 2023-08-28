@isTest
private class BitlyIntegrationTriggerTest {
	@isTest
    static void insert_BitlyIntegrationTrigger(){
        // Test data setup
        Tipo_de_Tanque__c tanque = new Tipo_de_Tanque__c();
        tanque.Name = 'Almacenamiento medido';
        tanque.Capacidad__c = 12345;
        tanque.URL_Corto__c = 'https://sforce.co/3E71RfR';
        
        // Call the method to be tested
        Test.startTest();
        INSERT tanque;
        Test.stopTest();
        
        // Verify the result using assertions
        Tipo_de_Tanque__c tanqueResponse = [SELECT Id, URL_Corto__c 
                                            FROM Tipo_de_Tanque__c 
                                            WHERE Id =:tanque.Id ];
        
        System.assertNotEquals(null, tanqueResponse.URL_Corto__c, 'La URL corta no debe ser nula');
        System.assertNotEquals('', tanqueResponse.URL_Corto__c, 'La URL corta no debe estar vacía');
    }
    @isTest
    static void update_BitlyIntegrationTrigger(){
        // Test data setup
        Tipo_de_Tanque__c tanque = new Tipo_de_Tanque__c();
        tanque.Name = 'Almacenamiento medido';
        tanque.Capacidad__c = 12345;
        tanque.URL_Corto__c = 'https://sforce.co/3E71RfR';
        INSERT tanque;
        tanque.Name = 'Almacenamiento desmedido' ;
        
        // Call the method to be tested
        Test.startTest();
        UPDATE tanque;
        Test.stopTest();
        
        // Verify the result using assertions
        Tipo_de_Tanque__c tanqueResponse = [SELECT Id, 
                                            Name FROM Tipo_de_Tanque__c 
                                            WHERE Id =:tanque.Id ];
        System.assertEquals('Almacenamiento desmedido', tanqueResponse.Name);
     
    }
}