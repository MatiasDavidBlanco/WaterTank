public class BitlyIntegration{

    
       
    //Método que recibe como parámetro lista de Tipos de Tanques
    public static void generateBitly(List<Tipo_de_Tanque__c > tiposDeTanques){
         System.debug('entro a clase');
        //Iterar sobre la lista recibida y por cada item llamar a la clase createBitly enviando sólo Id. 
        for (Tipo_de_Tanque__c tanque : tiposDeTanques) { 
            createBitly(tanque.Id);
        }	
    }
    
    
    //Método asíncrono que recibe como parámetro el Id de cada tipo de tanque
    @future(callout=true)
    public static void createBitly(Id tipoDeTanqueId){
        System.debug('entro a metodo');
        
        //Se recupera el registro en la base de datos con el Id recibido
        
        Tipo_de_Tanque__c tipoDeTanque = [SELECT Id, Name, Capacidad__c FROM Tipo_de_Tanque__c WHERE Id = :tipoDeTanqueId];
        
        //Se crea variable response de tipo map para almacenar respuesta que se recibirá 
        Map<String, Object> response = new Map<String,Object>();
      
        //Variable para almacenar endpoint
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
                'long_url' => System.Label.Base_URL + tipoDeTanque.Id
            })); 
            
            //Se envía petición y se almacena en variable res
            
            res = http.send(req);            
            response = (Map<String, Object>) JSON.deserializeUntyped(res.getBody());
            System.debug('RESPUESTA STRING:' + res.getBody());
            tipoDeTanque.URL_Corto__c  = (String) response.get('link');
            System.debug('RESULTADO : '+ tipoDeTanque);
            
            update tipoDeTanque;
   
        }catch (Exception e) {         
            System.debug('Error:' + e.getMessage() + 'Linea:' + e.getLineNumber() );           
        }
        
        
      
    }
 }
