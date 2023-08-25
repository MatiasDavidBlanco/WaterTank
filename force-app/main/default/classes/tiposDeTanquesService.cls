public with sharing class tiposDeTanquesService {

    @AuraEnabled(cacheable=true)
    public static List<Tipo_de_Tanque__c> getFilteredTiposDeTanque(String searchText ) {
        String likeValue='%' + searchText + '%';
        
        List<Tipo_de_Tanque__c> ListaTiposDeTanque = [SELECT Id, Name, URL_Imagen__c, Imagen__c, Precio_de_lista__c, Capacidad__c, Marca__c, URL_Corto__c FROM Tipo_de_Tanque__c WHERE Name LIKE :likeValue];
        return  ListaTiposDeTanque;
    }
}