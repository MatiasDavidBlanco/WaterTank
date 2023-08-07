public with sharing class BitlyServiceInvocable {
    @invocableMethod(label='Short URL' description='Obtener URL corta con bitly API')
    public static void shorten(List<id> websiteIds) {
        shortenFuture(websiteIds);

    }
}

    @future(callout=true)
    public static void shortenFuture(List<id> websiteIds){
        List<Website__c> websiteList = [SELECT Id,Name, Website_URL__c FROM Website__c WHERE Id in: websiteIds];
        BitlyService bservice = new BitlyService();

        for(Website__c : websiteList){
            string fullURL;
            if(website.Website_URL__c!=null){
                fullURL= website.Website_URL__c;
            }

            string shorturl = bservice.shorten(fullURL);
            website.Short_URL__C = shortUrl;
        }

        if(websiteList.size()>0){
            update websiteList;
        }
    }