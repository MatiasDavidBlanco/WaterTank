public with sharing class cSVLoaderService {

    @AuraEnabled
    public static String cSVLoaderDatos(Id contentDocumentId) {

        ContentVersion contentVersionObj = [ SELECT Id, VersionData FROM ContentVersion WHERE ContentDocumentId =:contentDocumentId ];

        List<Tanque_Industrial__c> tanquesList = new List<Tanque_Industrial__c>();

        String data= contentVersionObj.VersionData.toString();

        string[] csvFileLines=data.split('\n');

        for(Integer i=1;i<csvFileLines.size();i++){

            string[] csvRecordData = csvFileLines[i].split(',');

            Tanque_Industrial__c tanqueObj = new Tanque_Industrial__c() ;
            tanqueObj.Estado__c = csvRecordData[0] ;             
            tanqueObj.Numero_de_Serie__c = csvRecordData[1];
            tanqueObj.Tipo_de_Tanque__c = csvRecordData[2];
                                                            
            tanquesList.add(tanqueObj);   
        }

        insert tanquesList;

        return string.valueOf(tanquesList.size());
    }
}