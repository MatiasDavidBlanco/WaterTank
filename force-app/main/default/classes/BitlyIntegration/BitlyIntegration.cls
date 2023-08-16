
public class BitlyIntegration{
    
    public static void generateBitly(List<Tipo_de_Tanque__c > lstT){
        List<Id> tanquesLst = new List<Id>();
		tanquesLst.add(lstT[0].id);
        createBitly(tanquesLst);
    }
    
    @future(callout=true)
    public static void createBitly(List<Id> lstTId){
        List<Tipo_de_Tanque__c> lstT = [Select Id FROM Tipo_de_Tanque__c WHERE Id =: lstTId[0]];
        Map<String, Object> response = new Map<String,Object>();
        List<Tipo_de_Tanque__c> tanquesToUpdate = new List<Tipo_de_Tanque__c>();
        String endpoint = Label.Bitly_EndPoint + '/v4/shorten'; 

        try {                  
            HttpRequest req = new HttpRequest();
            HttpResponse res = new HttpResponse();
            Http http = new Http();
            req.setHeader('Authorization', Label.Bitly_AccessToken);
            req.setHeader('Content-Type', 'application/json');
            req.setHeader('Accept', 'application/json');
            req.setEndpoint(endpoint);
            req.setMethod('POST');
            req.setBody(JSON.serialize(new Map<String, Object>{               
                'group_guid' => Label.Bitly_GroupId,  
                'domain'=> 'bit.ly',
                // 'long_url' => 'System.label.Base_URL' + lstT[0].Id
                'long_url' => 'Label.Base_URL' + lstT[0].Id
            })); 

                // for eg. Base_URL = https://myorg-dev-ed.my.salesforce.com/

	    if(!Test.isRunningTest()) {      
	        res = http.send(req);            
	        response = (Map<String, Object>) JSON.deserializeUntyped(res.getBody());
	        System.debug('Str:' + res.getBody());
	        lstT[0].URL_Corto__c  = (String) response.get('link');
	        tanquesToUpdate.add(lstT[0]);
	    }                    
	}catch (Exception e) {         
	    System.debug('Error:' + e.getMessage() + 'LN:' + e.getLineNumber() );           
        }
        if(tanquesToUpdate.size()>0){
            update tanquesToUpdate;
        }
    }
}
