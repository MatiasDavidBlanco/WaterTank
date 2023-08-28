public with sharing class CSVController {
    @AuraEnabled
    public static string loadCSVData(Id contentDocumentId){

        ContentVersion contentVersionObj = [SELECT Id, VersionData 
                                            FROM ContentVersion 
                                            WHERE ContentDocumentId =:contentDocumentId ];

        //System.debug(contentVersionObj);

        List<Tanque_Industrial__c> tanquesIndustrialesList = new List<Tanque_Industrial__c>();
         
        String data= contentVersionObj.VersionData.toString();
        //System.debug('data: ' + data);

        String[] csvFileLines=data.split('\n');
        //System.debug('lineas del Archivo csv: ' + csvFileLines);

        Map<String, Id> mapConIdsTiposDeTanques = new Map<String, Id>();

        List <Tipo_de_Tanque__c> tiposDeTanqueList = [ SELECT Id, Name
                                                       FROM Tipo_de_Tanque__c];

        for (Tipo_de_Tanque__c tipo : tiposDeTanqueList){
            mapConIdsTiposDeTanques.put(tipo.Name, tipo.Id);
        }

        System.debug(mapConIdsTiposDeTanques);

        //System.debug('MAP CON LISTA DE IDS: ' + mapConIdsTiposDeTanques);

        for(Integer i=1 ; i < csvFileLines.size() ; i++){
            
            String[] csvRecordData = csvFileLines[i].split(',');
            System.debug(csvRecordData[0]);
            System.debug(csvRecordData[1]);
            System.debug(csvRecordData[2]);
            
            String pruebaId= mapConIdsTiposDeTanques.get(csvRecordData[0]);

            System.debug(pruebaId);
            Tanque_Industrial__c nuevoTanqueIndustrial = new Tanque_Industrial__c() ;
        

            nuevoTanqueIndustrial.Tipo_de_Tanque__c = mapConIdsTiposDeTanques.get(csvRecordData[0]);  
            nuevoTanqueIndustrial.Numero_de_Serie__c = csvRecordData[1];
            nuevoTanqueIndustrial.Estado__c = csvRecordData[2];
         
                                                                                
            tanquesIndustrialesList.add(nuevoTanqueIndustrial);
            
            
        }

        INSERT tanquesIndustrialesList;
        

        return string.valueOf(tanquesIndustrialesList.size());
    

    }
}