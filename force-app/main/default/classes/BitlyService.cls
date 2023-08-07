public with sharing class BitlyService {
    public string shorten( String websiteURL) {
        Http h = new HTTP();
        System.debug('websiteURL' + websiteURL);
        
        HttpRequest req = new HttpRequest();

        req.setMethod('POST');
        
        req.setEndPoint('callout:Bitly/v4/shorten');

        req.setHeader('Authorization', 'Bearer {!$Credential.Password}');
        req.setHeader('Acept', 'application/json');
        req.setHeader('Content-Type', 'application/json');

        req.setBody(JSON.serialize(new Map<string,Object>{
            'group_guid'=>'{!$Credential.Username}';
            'long_url'=> websiteURL;
            'domain'=>'bit.ly'
        }));

        HttpResponse res = h.send(req);

        Map<string,Object> response = (Map<string,Object>)JSON.deserializeUntyped(res.getBody());
        string shortUrl = (string) response.get('link');

        return shortUrl;
    }
}