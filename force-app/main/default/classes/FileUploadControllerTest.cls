@isTest
public with sharing class FileUploadControllerTest {

    @isTest
    static void FileUploadControllerTest() {

        // Test data setup
        ContentVersion testContentVersionObj = new ContentVersion(
            Title = 'Test CSV File',
            PathOnClient = 'test.csv',
            VersionData = Blob.valueOf('TipodeTanque,NumerodeSerie,Estado\nTipo1,Serial123,Disponible\nTipo2,Serial456,Disponible'),
            ContentLocation  = 'S'
        );
        INSERT testContentVersionObj;
        
        Id retrieveContentDocumentId = [SELECT ContentDocumentId 
                                        FROM ContentVersion 
                                        WHERE Id = :testContentVersionObj.Id].ContentDocumentId;

        Tipo_de_Tanque__c testTipo1 = new Tipo_de_Tanque__c(Name = 'Tipo1');  
        Tipo_de_Tanque__c testTipo2 = new Tipo_de_Tanque__c(Name = 'Tipo2');

        INSERT testTipo1;
        INSERT testTipo2;

        // Call the method to be tested
        Test.startTest();
        String result = FileUploadController.loadCSVData(retrieveContentDocumentId);
        Test.stopTest();
        
        // Verify results
        List<Tanque_Industrial__c> insertedRecords = [SELECT Id FROM Tanque_Industrial__c];
        System.assertEquals(2, insertedRecords.size(), 'Incorrect number of records inserted');
        System.assertEquals('2', result, 'Returned count does not match the number of inserted records');
    }

}


