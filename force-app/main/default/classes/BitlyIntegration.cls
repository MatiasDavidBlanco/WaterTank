public class BitlyIntegration{
    
    // Method that receives a list of Tank Types as a parameter
    public static void generateBitly(List<Tipo_de_Tanque__c > tiposDeTanques){
         
        // Iterate over the received list and for each item, call the createBitly class by sending only the Id.
        for (Tipo_de_Tanque__c tanque : tiposDeTanques) { 
            createBitly(tanque.Id);
        }	
    }
    // Asynchronous method that receives the Id of each tank type as a parameter
    @future(callout=true)
    public static void createBitly(Id tipoDeTanqueId){
        
        // Retrieve the record from the database with the received Id
        Tipo_de_Tanque__c tipoDeTanque = [SELECT Id, Name, Capacidad__c 
                                         FROM Tipo_de_Tanque__c 
                                         WHERE Id = :tipoDeTanqueId];
        
        Map<String, Object> response = new Map<String,Object>();
        String endpoint = System.Label.Bitly_EndPoint; 
        //String endpoint = System.Label.Bitly_EndPoint + '/v4/shorten'; 
          
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
                'long_url' => System.Label.Base_URL + tipoDeTanque.Id +'/view'
            })); 
            
            // Send the request and store it in the 'res' variable
            res = http.send(req);            
            response = (Map<String, Object>) JSON.deserializeUntyped(res.getBody());
            System.debug('RESPUESTA STRING:' + res.getBody());
            tipoDeTanque.URL_Corto__c  = (String) response.get('link');
            System.debug('RESULTADO : '+ tipoDeTanque);
            
            UPDATE tipoDeTanque;
   
        }catch (Exception e) {         
            System.debug('Error:' + e.getMessage() + 'Linea:' + e.getLineNumber() );           
        }      
    }
 }