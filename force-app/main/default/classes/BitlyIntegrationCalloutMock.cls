@isTest
global class BitlyIntegrationCalloutMock implements HttpCalloutMock {
    // Implement this interface method
    global HTTPResponse respond(HTTPRequest request){
        // Create a fake response
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        response.setHeader('Accept', 'application/json');
        response.setBody('{"link": "https://bit.ly/shortlink"}');
        response.setStatusCode(200);
        return response;
    }

}