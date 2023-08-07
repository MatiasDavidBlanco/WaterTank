trigger assignTankOpp on Opportunity (before insert) {

    Opportunity opp = Trigger.New[0];

    List<Tanque_Industrial__c> tanks = new List<Tanque_Industrial__c>();
    tanks= [
        SELECT Id 
        FROM Tanque_Industrial__c 
        WHERE Capacidad__c =: opp.Capacidad__c 
        AND Estado__c = 'Disponible' 
        AND Tipo_de_Tanque__r.Precio_de_lista__c >=: opp.Precio_Minimo__c 
        AND Tipo_de_Tanque__r.Precio_de_lista__c <=: opp.Precio_maximo__c 
        AND Tipo_de_Tanque__c =: opp.Tipo_de_Tanque__c
        ];

    System.debug('Tanque' + tanks);
    
    if(tanks.size()>0){
        // opp.Tanque_SeleccionadoLOOKUP__c = tanks[0].Id;
        opp.Tanque_Seleccionado__c = tanks[0].Id;
        tanks[0].Estado__c = 'Reservado';
        update tanks;
    }else{
        Pedido__c pedido = new Pedido__c(Estado__c= 'Pendiente', Tipo_de_Tanque__c = opp.Tipo_de_Tanque__c);
        insert pedido; 
        opp.Pedido__c = pedido.Id;
    }
}

