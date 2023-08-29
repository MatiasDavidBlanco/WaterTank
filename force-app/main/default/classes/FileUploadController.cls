public with sharing class FileUploadController {
    @AuraEnabled
    public static String loadCSVData(Id contentDocumentId){
       
        // Retrieve the ContentVersion object based on the provided ContentDocumentId
        ContentVersion contentVersionObj = [SELECT Id, VersionData 
                                            FROM ContentVersion 
                                            WHERE ContentDocumentId =:contentDocumentId 
                                            LIMIT 1];
        
        System.debug(contentVersionObj);

        List<Tanque_Industrial__c> tanquesIndustrialesList = new List<Tanque_Industrial__c>();
         
        // Convert CSV file data into a string
        String data= contentVersionObj.VersionData.toString();
        System.debug(data);
        // Split the CSV data into individual lines
        String[] csvFileLines=data.split('\n');

        Map<String, Id> mapConIdsTiposDeTanques = new Map<String, Id>();

        List <Tipo_de_Tanque__c> tiposDeTanqueList = [SELECT Id, Name
                                                      FROM Tipo_de_Tanque__c];

        for (Tipo_de_Tanque__c tipo : tiposDeTanqueList){
            mapConIdsTiposDeTanques.put(tipo.Name, tipo.Id);
        }
        // Loop through each CSV record and create Tanque_Industrial__c records
        for(Integer i=1 ; i < csvFileLines.size() ; i++){
            
            // Split the current CSV line into an array of values using comma as the delimiter
            String[] csvRecordData = csvFileLines[i].split(',');

            Tanque_Industrial__c nuevoTanqueIndustrial = new Tanque_Industrial__c() ;
        
            nuevoTanqueIndustrial.Tipo_de_Tanque__c = mapConIdsTiposDeTanques.get(csvRecordData[0]);  
            nuevoTanqueIndustrial.Numero_de_Serie__c = csvRecordData[1];
            nuevoTanqueIndustrial.Estado__c = csvRecordData[2];
                                                                                 
            tanquesIndustrialesList.add(nuevoTanqueIndustrial);
        }

        INSERT tanquesIndustrialesList;
        
        // Return the count of inserted records as a string
        return string.valueOf(tanquesIndustrialesList.size());
    
    }
}