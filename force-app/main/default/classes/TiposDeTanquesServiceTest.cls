@isTest
private class TiposDeTanquesServiceTest {
    @isTest
    static void GetFilteredTiposDeTanqueTest() {
        // Preparación
        Tipo_de_Tanque__c tipoDeTanque = new Tipo_de_Tanque__c(Name = 'Test Tanque', Capacidad__c = 100, Marca__c = 'ProLine Industrial Tanks');
        insert tipoDeTanque;

        // Ejecución
        Test.startTest();
        List<Tipo_de_Tanque__c> result = tiposDeTanquesService.getFilteredTiposDeTanque('Test');
        Test.stopTest();

        // Verificación
        System.assertEquals(1, result.size(), 'Debería haber un tipo de tanque en el resultado');
        Tipo_de_Tanque__c retrievedTipoDeTanque = result[0];
        System.assertEquals('Test Tanque', retrievedTipoDeTanque.Name, 'El nombre del tipo de tanque no coincide');
    }
}