@isTest
public with sharing class testAssignTankOpp {

     // Esta prueba simula la creación exitosa de una oportunidad y verifica si se realiza correctamente la asignación de un tanque disponible a la oportunidad. 

     @isTest
   public static void testingTrueAssign() {
        Tipo_de_Tanque__c tipoDeTanque = new Tipo_de_Tanque__c(Capacidad__c = 500, Marca__c = 'Aquavault Solutions', Precio_de_lista__c = 4000);
        insert tipoDeTanque;

        Tanque_Industrial__c tanque = new Tanque_Industrial__c(Tipo_de_Tanque__c = tipoDeTanque.Id, Numero_de_serie__c = 'sdkjhd233', Estado__c= 'Disponible');
        insert tanque;

        Opportunity opp = new Opportunity (Name='Matias', StageName='Open', CloseDate = System.Today() + 14, Precio_Minimo__c = 3000, Precio_maximo__c = 5000, Tipo_de_Tanque__c = tipoDeTanque.Id, Capacidad__c = 500);
        insert opp;

        Opportunity opp2 = [SELECT Id, Tanque_SeleccionadoLOOKUP__c FROM Opportunity WHERE Id =: opp.Id LIMIT 1];
        System.assertEquals(tanque.Id, opp2.Tanque_SeleccionadoLOOKUP__c);

   }

     //  Esta prueba verifica que cuando no se encuentra un tanque adecuado para la oportunidad, el campo Tanque_SeleccionadoLOOKUP__c se mantenga como nulo.
     
   @isTest
   public static void testingFalseAssign() {
        Tipo_de_Tanque__c tipoDeTanque = new Tipo_de_Tanque__c(Capacidad__c = 500, Marca__c = 'Aquavault Solutions', Precio_de_lista__c = 4000);
        insert tipoDeTanque;

        Tanque_Industrial__c tanque = new Tanque_Industrial__c(Tipo_de_Tanque__c = tipoDeTanque.Id, Numero_de_serie__c = 'sdkjhd233', Estado__c= 'Disponible');
        insert tanque;

        Opportunity opp = new Opportunity (Name='Matias', StageName='Open', CloseDate = System.Today() + 14, Precio_Minimo__c = 3000, Precio_maximo__c = 5000, Tipo_de_Tanque__c = tipoDeTanque.Id);
        insert opp;

        Opportunity opp2 = [SELECT Id, Tanque_SeleccionadoLOOKUP__c FROM Opportunity WHERE Id =: opp.Id LIMIT 1];
        System.assertEquals(null, opp2.Tanque_SeleccionadoLOOKUP__c);

   }
}