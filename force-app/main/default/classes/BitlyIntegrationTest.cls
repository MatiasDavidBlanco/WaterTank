@isTest
public class BitlyIntegrationTest {

    @isTest
    static void testGenerateBitly() {
        
        // Crear datos de prueba
        Tipo_de_Tanque__c tanque = new Tipo_de_Tanque__c(Name = 'Tanque de Prueba');
        insert tanque;

        Test.startTest();
        // Usar el mock HTTP en las pruebas
        Test.setMock(HttpCalloutMock.class, new BitlyIntegrationCalloutMock());

        // Llamar al método de la clase BitlyIntegration para probar
        List<Tipo_de_Tanque__c> tiposDeTanques = new List<Tipo_de_Tanque__c>{ tanque };
        BitlyIntegration.generateBitly(tiposDeTanques);

        Test.stopTest();

        // Realizar comparaciones para verificar que el comportamiento esperado ocurrió
        Tipo_de_Tanque__c updatedTanque = [SELECT Id, URL_Corto__c FROM Tipo_de_Tanque__c WHERE Id = :tanque.Id];
        //System.assertEquals(200, response.getStatusCode());
        System.assertEquals('https://bit.ly/shortlink', updatedTanque.URL_Corto__c);
    }
    
    @isTest
    static void testGenerateBitlyWithException() {
        // Crear datos de prueba
        Tipo_de_Tanque__c tanque = new Tipo_de_Tanque__c(Name = 'Tanque de Prueba');
        insert tanque;

        Test.startTest();
        // Usar el mock HTTP en las pruebas para forzar una excepción
        Test.setMock(HttpCalloutMock.class, new BitlyIntegrationCalloutExceptionMock());

        // Llamar al método de la clase BitlyIntegration para probar
        List<Tipo_de_Tanque__c> tiposDeTanques = new List<Tipo_de_Tanque__c>{ tanque };
        BitlyIntegration.generateBitly(tiposDeTanques);

        Test.stopTest();

        // Realizar comparaciones para verificar que el comportamiento esperado ocurrió
        Tipo_de_Tanque__c updatedTanque = [SELECT Id, URL_Corto__c FROM Tipo_de_Tanque__c WHERE Id = :tanque.Id];
        System.assert(updatedTanque.URL_Corto__c == null);
    }
}
