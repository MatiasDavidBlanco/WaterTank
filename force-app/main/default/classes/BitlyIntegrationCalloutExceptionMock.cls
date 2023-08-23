@isTest
global class BitlyIntegrationCalloutExceptionMock implements HttpCalloutMock {
    global HttpResponse respond(HttpRequest req) {
        HttpResponse res = new HttpResponse();
        res.setStatusCode(500); // Simulando un error en el callout
        return res;
    }
}