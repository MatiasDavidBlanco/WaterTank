public class OpportunityTrigger_Handler{

    public static void seleccionarTanque(List<Opportunity> Oportunidades){

        // Crear una lista para almacenar las oportunidades nuevas
        List<Opportunity> newOpportunities = new List<Opportunity>();

         // Recorrer las oportunidades nuevas para agregarlas a la lista
        for (Opportunity opp : Oportunidades) {
            newOpportunities.add(opp);
        }


        // Crear una lista para almacenar los tanques disponibles que cumplan las condiciones
       
        List<Tanque_Industrial__c> tanks = [ 
            SELECT Id, Capacidad__c, Tipo_de_Tanque__c, Tipo_de_Tanque__r.Precio_de_lista__c
            FROM Tanque_Industrial__c 
            WHERE Capacidad__c IN :newOpportunities 
                AND Estado__c = 'Disponible'
                AND Tipo_de_Tanque__r.Precio_de_lista__c >= :newOpportunities.Precio_Minimo__c
                AND Tipo_de_Tanque__r.Precio_de_lista__c <= :newOpportunities.Precio_maximo__c
                AND Tipo_de_Tanque__c = :newOpportunities.Tipo_de_Tanque__c
            ];


            
            // for (Tanque_Industrial__c tank : [SELECT Id, Capacidad__c, Tipo_de_Tanque__c, Tipo_de_Tanque__r.Precio_de_lista__c FROM Tanque_Industrial__c WHERE Capacidad__c IN :newOpportunities AND Estado__c = 'Disponible' AND Tipo_de_Tanque__r.Precio_de_lista__c >= :newOpportunities.Precio_Minimo__c AND Tipo_de_Tanque__r.Precio_de_lista__c <= :newOpportunities.Precio_maximo__c AND Tipo_de_Tanque__c = :newOpportunities.Tipo_de_Tanque__c]){
                
            //     if (listaDeProductos.contains(opp.Producto__c)) {
            //         oportunidades.add(opp);
            //     }
            // }
            
            // System.debug(oportunidades);
            


        // Recorrer las oportunidades nuevas para asignar tanques o crear pedidos

        for (Opportunity opp : newOpportunities) {
            
            // Crear una lista para almacenar los tanques que coincidan con la capacidad de la oportunidad
            List<Tanque_Industrial__c> matchingTanks = new List<Tanque_Industrial__c>();

            // Buscar tanques que tengan la misma capacidad que la oportunidad
            for (Tanque_Industrial__c tank : tanks) {
                if (tank.Capacidad__c == opp.Capacidad__c) {
                    matchingTanks.add(tank);
                }
            }

            // Si se encontraron tanques, asignar el primero y cambiar su estado
            if (!matchingTanks.isEmpty()) {
                opp.Tanque_SeleccionadoLOOKUP__c = matchingTanks[0].Id;
                matchingTanks[0].Estado__c = 'Reservado';
            } else {
                // Si no se encontraron tanques, crear un nuevo pedido
                Pedido__c pedido = new Pedido__c(Estado__c = 'Pendiente', Tipo_de_Tanque__c = opp.Tipo_de_Tanque__c);
                insert pedido;
                opp.Pedido__c = pedido.Id;
            }
        }

        // Actualizar los estados de los tanques
        update tanks;

    }

}