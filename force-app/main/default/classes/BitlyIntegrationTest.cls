@isTest
public class BitlyIntegrationTest {

    @isTest
    static void testGenerateBitly() {
        
        // Test data setup
        Tipo_de_Tanque__c tanque = new Tipo_de_Tanque__c(Name = 'Tanque de Prueba');
        INSERT tanque;

        // Call the method to be tested
        Test.startTest();
       // Configuration of the mock HTTP that simulates HTTP calls to Bitly
        Test.setMock(HttpCalloutMock.class, new BitlyIntegrationCalloutMock());
        
        List<Tipo_de_Tanque__c> tiposDeTanques = new List<Tipo_de_Tanque__c>{ tanque };
        BitlyIntegration.generateBitly(tiposDeTanques);
		Test.stopTest();

         // Verify the result using assertions
        Tipo_de_Tanque__c updatedTanque = [SELECT Id, URL_Corto__c 
                                           FROM Tipo_de_Tanque__c 
                                           WHERE Id = :tanque.Id];
        System.assertEquals('https://bit.ly/shortlink', updatedTanque.URL_Corto__c);
    }
    
    @isTest
    static void testGenerateBitlyWithException() {
        
         // Test data setup
        Tipo_de_Tanque__c tanque = new Tipo_de_Tanque__c(Name = 'Tanque de Prueba');
        INSERT tanque;
        
		// Call the method to be tested
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new BitlyIntegrationCalloutExceptionMock());
        List<Tipo_de_Tanque__c> tiposDeTanques = new List<Tipo_de_Tanque__c>{ tanque };
        BitlyIntegration.generateBitly(tiposDeTanques);
        Test.stopTest();

        // Verify the result using assertions
        Tipo_de_Tanque__c updatedTanque = [SELECT Id, URL_Corto__c 
                                           FROM Tipo_de_Tanque__c 
                                           WHERE Id = :tanque.Id];
        System.assert(updatedTanque.URL_Corto__c == null);
    }
}