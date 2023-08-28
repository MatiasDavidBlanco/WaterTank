@isTest
global class BitlyIntegrationCalloutMock implements HttpCalloutMock {
    // Implementation of a method from this interface
    global HTTPResponse respond(HTTPRequest request){
        // Create fake response
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        response.setHeader('Accept', 'application/json');
        response.setBody('{"link": "https://bit.ly/shortlink"}');
        response.setStatusCode(200);
        return response;
    }

}