public class BitlyIntegration {
	 // Método para obtener el enlace corto de Bitly y actualizar el campo "URL Corto" en el registro del tanque
    @future (callout=true)
    public static void obtenerEnlaceCorto(List<Id> tanqueId) {
        String bitlyToken = 'beb4ccc0140d4cb367990e3738d4b09eb1973c91';
        String urlLarga = 'https://ventixproyect-dev-ed.develop.lightning.force.com/lightning/r/Tipo_de_Tanque__c/' + tanqueId; 
        
        // Construir la URL de la API de Bitly para acortar el enlace
        String bitlyApiUrl = 'https://api-ssl.bitly.com/v4/shorten';
        HttpRequest request = new HttpRequest();
        request.setEndpoint(bitlyApiUrl);
        request.setMethod('POST');
        request.setHeader('Authorization', 'Bearer ' + bitlyToken);
        request.setHeader('Content-Type', 'application/json');
        
        // Crear el cuerpo de la solicitud con la URL larga
        Map<String, Object> requestBody = new Map<String, Object>();
        requestBody.put('long_url', urlLarga);
        String jsonBody = JSON.serialize(requestBody);
        request.setBody(jsonBody);
        
        // Realizar la solicitud HTTP
        Http http = new Http();
        HttpResponse response = http.send(request);
        
        // Procesar la respuesta de Bitly
        if (response.getStatusCode() == 200) {
            Map<String, Object> jsonResponse = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
            String urlCorta = (String) jsonResponse.get('id');
            
            // Actualizar el campo "URL Corto" en el registro del tanque
            Tipo_de_Tanque__c tanque = [SELECT Id, URL_Corto__c FROM Tipo_de_Tanque__c WHERE Id = :tanqueId LIMIT 1];
            tanque.URL_Corto__c = urlCorta;
            update tanque;
            System.debug('enlace:'+ urlCorta);
        } else {
            System.debug('Error al obtener el enlace corto de Bitly: ' + response.getBody());
        }
    }
}