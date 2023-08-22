public class BitlyIntegration{
    
    public static void generateBitly(List<Tipo_de_Tanque__c > lstT){
    	
        for (Tipo_de_Tanque__c i : lstT) { 
            createBitly(lstT[i]);
        }
    }
    
    @future(callout=true)
    public static void createBitly(List<Id> lstTId){

        List<Tipo_de_Tanque__c> lstTT = [Select Id FROM Tipo_de_Tanque__c WHERE Id =: lstTId];
        Map<String, Object> response = new Map<String,Object>();
        List<Tipo_de_Tanque__c> tanquesToUpdate = new List<Tipo_de_Tanque__c>();
        String endpoint = System.Label.Bitly_EndPoint + '/v4/shorten'; 

        try {                  
            HttpRequest req = new HttpRequest();
            HttpResponse res = new HttpResponse();
            Http http = new Http();
            req.setHeader('Authorization', System.Label.Bitly_AccessToken);
            req.setHeader('Content-Type', 'application/json');
            req.setHeader('Accept', 'application/json');
            req.setEndpoint(endpoint);
            req.setMethod('POST');
            req.setBody(JSON.serialize(new Map<String, Object>{               
                'group_guid' => System.Label.Bitly_GroupId,  
                'domain'=> 'bit.ly',
                'long_url' => System.Label.Base_URL + lstTId.Id
            })); 

                // for eg. Base_URL = https://myorg-dev-ed.my.salesforce.com/

	        res = http.send(req);            
	        response = (Map<String, Object>) JSON.deserializeUntyped(res.getBody());
	        System.debug('Str:' + res.getBody());
	        lstT.URL_Corto__c  = (String) response.get('link');
	        tanquesToUpdate.add(lstT);
   
	}catch (Exception e) {         
	    System.debug('Error:' + e.getMessage() + 'LN:' + e.getLineNumber() );           
        }
        if(tanquesToUpdate.size()>0){
            update tanquesToUpdate;
        }
    }
}
 