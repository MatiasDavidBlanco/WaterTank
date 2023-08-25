@isTest
public class BitlyIntegrationTest {

    @isTest
    static void testGenerateBitly() {
        
        //Preparación
        Tipo_de_Tanque__c tanque = new Tipo_de_Tanque__c(Name = 'Tanque de Prueba');
        insert tanque;

        //Ejecución
        Test.startTest();
       	// Configuración del mock HTTP que simula llamadas HTTP a Bitly
        Test.setMock(HttpCalloutMock.class, new BitlyIntegrationCalloutMock());
        
        List<Tipo_de_Tanque__c> tiposDeTanques = new List<Tipo_de_Tanque__c>{ tanque };
        BitlyIntegration.generateBitly(tiposDeTanques);
		Test.stopTest();

        //Verificación
        Tipo_de_Tanque__c updatedTanque = [SELECT Id, URL_Corto__c FROM Tipo_de_Tanque__c WHERE Id = :tanque.Id];
        System.assertEquals('https://bit.ly/shortlink', updatedTanque.URL_Corto__c);
    }
    
    @isTest
    static void testGenerateBitlyWithException() {
        
        //Preparación
        Tipo_de_Tanque__c tanque = new Tipo_de_Tanque__c(Name = 'Tanque de Prueba');
        insert tanque;
        
		//Ejecución
        Test.startTest();
        
        // Configuración del mock HTTP que simula llamadas HTTP a Bitly pero provoca excepciones controladas
        Test.setMock(HttpCalloutMock.class, new BitlyIntegrationCalloutExceptionMock());

        List<Tipo_de_Tanque__c> tiposDeTanques = new List<Tipo_de_Tanque__c>{ tanque };
        BitlyIntegration.generateBitly(tiposDeTanques);

        Test.stopTest();

        //Verificación
        Tipo_de_Tanque__c updatedTanque = [SELECT Id, URL_Corto__c FROM Tipo_de_Tanque__c WHERE Id = :tanque.Id];
        System.assert(updatedTanque.URL_Corto__c == null);
    }
}