trigger assignTankOpp on Opportunity (before insert) {

    //Guardo en una variable el regitro que disparó el trigger
    Opportunity opp = Trigger.New[0];
    //Query para traer tanques industriales bajo ciertas condiciones
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
    
    //Comprobación para evaluar:
        // Si trajo un tanque, realizar asignaciones en campos de opp
        // Si NO trajo un tanque, realizar creación de un nuevo pedido 
    if(tanks.size()>0){
        opp.Tanque_SeleccionadoLOOKUP__c = tanks[0].Id;
        tanks[0].Estado__c = 'Reservado';
        update tanks;
    }else{
        Pedido__c pedido = new Pedido__c(Estado__c= 'Pendiente', Tipo_de_Tanque__c = opp.Tipo_de_Tanque__c);
        insert pedido; 
        opp.Pedido__c = pedido.Id;
    }
}



