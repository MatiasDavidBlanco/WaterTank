@isTest
global class BitlyIntegrationCalloutMock implements HttpCalloutMock {
    // Implementación de un método de esta interfaz
    global HTTPResponse respond(HTTPRequest request){
        // Crear respuesta simulada
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        response.setHeader('Accept', 'application/json');
        response.setBody('{"link": "https://bit.ly/shortlink"}');
        response.setStatusCode(200);
        return response;
    }

}